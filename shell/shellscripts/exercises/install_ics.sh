#!/bin/bash
# This script installs ics drivers and their dependencies into
# kolla-ansible deployed OpenStack environment.

set -e
CURRENT_DIR=$(readlink -f "$(dirname $0)")

###############################################################
# Configurations of the underlying env for ics drivers.
###############################################################
ICS_HOST_URL="100.2.22.28"
ICS_CLUSTER="cluster"
ICS_USERNAME="admin"
ICS_PASSWORD="admin@inspur"
ICS_DVS_NAME="openstack"
ICS_DATASTORE_NAME="openstackcfs"
ICS_DATACENTER_NAME="datacenter"
ICS_PORTGROUP_PREFIX="openstack"

###############################################################
# Environment veriables.
###############################################################
# Indicate wheather to aquire ics code from [online] or [offline].
# If "file", source files should under the same path as this script.
INSTALL_TYPE="offline"
# Base git repo url from where to checkout ics-drivers' source.
BASE_GIT_URL="http://100.2.22.185/ics-openstack"
# Default branch when cloning sources.
ICS_BRANCH="stable/ocata"
# Install pypi from index.
PIP_OPTIONS="-i http://100.2.22.161/simple --trusted-host 100.2.22.161"

# Array of ics projects.
ICS_PROJECTS=("nova-inspur-ics" "cinder-inspur-ics" "neutron-inspur-ics" "glance_store" "ics-sdk")

# $HOST_ICS_PATH mounted on every container as a shared folder
# which can be used to pass files into containers.
# $CONTAINER_ICS_PATH is the corresponding path inside containers.
HOST_ICS_PATH="/var/lib/docker/volumes/kolla_logs/_data/ics"
CONTAINER_ICS_PATH="/var/log/kolla/ics"

# Custom configurations should be put in $CUSTOM_CONFIG_PATH.
CUSTOM_CONFIG_PATH="/etc/kolla/config"

# Nova containers that should be reconfiged.
#NOVA_CONTAINERS=("nova_api" "nova_compute" "nova_conductor" "nova_scheduler" "nova_consoleauth" "nova_novncproxy")
NOVA_CONTAINERS=("nova_api" "nova_compute" "nova_conductor" "nova_scheduler")
# Cinder containers that should be reconfiged.
CINDER_CONTAINERS=("cinder_api" "cinder_backup" "cinder_scheduler" "cinder_volume")
# Neutron containers that should be reconfiged.
NEUTRON_CONTAINERS=("neutron_server" "neutron_metadata_agent" "neutron_l3_agent" "neutron_dhcp_agent" "neutron_openvswitch_agent")
# Glance containers that should be reconfiged.
GLANCE_CONTAINERS=("glance_api")


###############################################################
# Functions.
###############################################################
function prepare() {
    echo -e "\n########################################"
    echo "Preparation"
    echo "########################################"

    # Make directory
    mkdir -p ${HOST_ICS_PATH}/scripts

    cd ${HOST_ICS_PATH}
    if [ ${INSTALL_TYPE} = "online" ]; then
        # Prepare source codes
        for p in ${ICS_PROJECTS[@]}; do
            if [ -d "$p" ]; then
                cd $p; git pull; cd ..
            elif [ $p = "ics-sdk" ]; then
                git clone ${BASE_GIT_URL}/$p.git -b master
            else
                git clone ${BASE_GIT_URL}/$p.git -b ${ICS_BRANCH}
            fi
        done
    elif [ ${INSTALL_TYPE} = "offline" ]; then
        cd ${CURRENT_DIR}
        # Prepare source codes
        for p in ${ICS_PROJECTS[@]}; do
            if [ -d "$p" ]; then
                cp -r $p ${HOST_ICS_PATH}
            else
                echo "$p source not exist!"; exit 1
            fi
        done

        PIP_OPTIONS="--no-index --find-links=${CONTAINER_ICS_PATH}/pypi"
        # Prepare pypi packages
        if [ -d ${CURRENT_DIR}/pypi ]; then
            cp -r ${CURRENT_DIR}/pypi ${HOST_ICS_PATH}
        else
            echo "Pypi packages does not exist!"; exit 1
        fi
        echo "OK!"
    else
        echo "INSTALL_TYPE not correct."
        exit 1
    fi

}

function add_nova_config() {
    echo -e "\n########################################"
    echo "Install ICS into nova containers"
    echo "########################################"
    mkdir -p ${CUSTOM_CONFIG_PATH}
    cat > ${CUSTOM_CONFIG_PATH}/nova.conf << EOF
[DEFAULT]
compute_driver = incloud_sphere.IcsDriver
[inspur_ics]
ics_cluster = ${ICS_CLUSTER}
ics_host_url = https://${ICS_HOST_URL}
ics_datastore_name = ${ICS_DATASTORE_NAME}
ics_data_center_name = ${ICS_DATACENTER_NAME}
ics_dvs = ${ICS_DVS_NAME}
ics_host_username = ${ICS_USERNAME}
ics_host_password = ${ICS_PASSWORD}
EOF
}

function prep_nova_containers() {
    cat > ${HOST_ICS_PATH}/scripts/prep_nova.sh << EOF
#!/bin/bash
pip install requests_toolbelt ${PIP_OPTIONS}
cd ${CONTAINER_ICS_PATH}
cd ics-sdk;python setup.py install;cd ..
cd nova-inspur-ics/
python setup.py install
cp -r nova/virt/incloud_sphere/ /var/lib/kolla/venv/lib/python2.7/site-packages/nova/virt
EOF

    for c in ${NOVA_CONTAINERS[@]}; do
        echo -e "\n########## $c ##########"
        docker exec -u root $c /bin/bash ${CONTAINER_ICS_PATH}/scripts/prep_nova.sh
    done
}


function add_cinder_config() {
    echo -e "\n########################################"
    echo "Install ICS into cinder containers"
    echo "########################################"
    mkdir -p ${CUSTOM_CONFIG_PATH}
    cat > ${CUSTOM_CONFIG_PATH}/cinder.conf << EOF
[DEFAULT]
default_volume_type = inspur-ics
enabled_backends = inspur-ics
[inspur-ics]
image_volume_cache_enabled = True
ics_host_url = https://${ICS_HOST_URL}
ics_host_username = ${ICS_USERNAME}
ics_host_password = ${ICS_PASSWORD}
ics_insecure = True
ics_data_center_name = ${ICS_DATACENTER_NAME}
ics_datastore_names = ${ICS_DATASTORE_NAME}
volume_group = stack-volumes-inspur-ics
volume_driver = cinder.volume.drivers.inspur_ics.ics.IcsDriver
volume_backend_name = inspur-ics
EOF
}

function prep_cinder_containers() {
    cat > ${HOST_ICS_PATH}/scripts/prep_cinder.sh << EOF
#!/bin/bash
pip install requests_toolbelt ${PIP_OPTIONS}
cd ${CONTAINER_ICS_PATH}
cd ics-sdk;python setup.py install;cd ..
cp -r cinder-inspur-ics/inspur_ics/ /var/lib/kolla/venv/lib/python2.7/site-packages/cinder/volume/drivers/
EOF

    for c in ${CINDER_CONTAINERS[@]}; do
        echo -e "\n########## $c ##########"
        docker exec -u root $c /bin/bash ${CONTAINER_ICS_PATH}/scripts/prep_cinder.sh
    done
}

function add_neutron_config() {
    echo -e "\n########################################"
    echo "Install ICS into neutron containers"
    echo "########################################"
    mkdir -p ${CUSTOM_CONFIG_PATH}/neutron
    cat > ${CUSTOM_CONFIG_PATH}/neutron/ml2_conf.ini << EOF
[ml2]
tenant_network_types = vlan,flat
extension_drivers = port_security
type_drivers = vlan,local,flat,gre,vxlan
mechanism_drivers = ics_dvs
[ml2_type_flat]
flat_networks = default,public,
[ml2_type_vlan]
network_vlan_ranges = default:100:900
[securitygroup]
firewall_driver = iptables_hybrid
[ovs]
bridge_mappings = default:br-ex
[ics_dvs]
ics_url = https://${ICS_HOST_URL}
ics_username = ${ICS_USERNAME}
ics_password = ${ICS_PASSWORD}
ics_dvs = ${ICS_DVS_NAME}
ics_pg_prefix = ${ICS_PORTGROUP_PREFIX}
EOF
}

function prep_neutron_containers() {
    cat > ${HOST_ICS_PATH}/scripts/prep_neutron.sh << EOF
#!/bin/bash
pip install requests_toolbelt ${PIP_OPTIONS}
cd ${CONTAINER_ICS_PATH}
cd ics-sdk;python setup.py install;cd ..
cd neutron-inspur-ics/;python setup.py install;cd ..
EOF

    for c in ${NEUTRON_CONTAINERS[@]}; do
        echo -e "\n########## $c ##########"
        docker exec -u root $c /bin/bash ${CONTAINER_ICS_PATH}/scripts/prep_neutron.sh
    done
}

function add_glance_config() {
    echo -e "\n########################################"
    echo "Install ICS into glance containers"
    echo "########################################"
    mkdir -p ${CUSTOM_CONFIG_PATH}
    cat > ${CUSTOM_CONFIG_PATH}/glance.conf << EOF
[glance_store]
inspur_ics_username = ${ICS_USERNAME}
inspur_ics_password = ${ICS_PASSWORD}
ics_dvs = ${ICS_DVS_NAME}
inspur_ics_datacenter = ${ICS_DATACENTER_NAME}
inspur_ics_datastore = ${ICS_DATASTORE_NAME}
inspur_ics_host = https://${ICS_HOST_URL}
https_insecure = True
https_ca_certificates_file = None
http_proxy_information = {http://${ICS_HOST_URL}}
default_store = http
stores = http
EOF
}

function prep_glance_containers() {
    cat > ${HOST_ICS_PATH}/scripts/prep_glance.sh << EOF
#!/bin/bash
pip install requests_toolbelt ${PIP_OPTIONS}
cd ${CONTAINER_ICS_PATH}
cd ics-sdk;python setup.py install;cd ..
mv /var/lib/kolla/venv/lib/python2.7/site-packages/glance_store/_drivers/http.py /tmp/http.py
cp -f glance_store/glance_store/_drivers/http.py /var/lib/kolla/venv/lib/python2.7/site-packages/glance_store/_drivers/http.py
EOF

    for c in ${GLANCE_CONTAINERS[@]}; do
        echo -e "\n########## $c ##########"
        docker exec -u root $c /bin/bash ${CONTAINER_ICS_PATH}/scripts/prep_glance.sh
    done
}

###############################################################
# The main process goes from here.
###############################################################
prepare

add_nova_config
prep_nova_containers

add_cinder_config
prep_cinder_containers

add_neutron_config
prep_neutron_containers

add_glance_config
prep_glance_containers

echo -e "\n########################################"
echo "kolla-ansible reconfigure"
echo "########################################"
#kolla-ansible reconfigure
