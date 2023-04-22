# RHEL-ImageBuilder
Learn custom image building using RHEL8 Image Builder.

# Prerequisites

You must be connected to a RHEL VM.
The VM for image builder must be running and subscribed to Red Hat Subscription Manager (RHSM) or Red Hat Satellite.

# Procedure

Install the image builder and other necessary packages by running below commands:

    osbuild-composer - supported from RHEL 8.3 onward
    composer-cli
    cockpit-composer
    bash-completion

command:

    # dnf install osbuild-composer composer-cli cockpit-composer bash-completion

Enable image builder to start after each reboot:

    systemctl enable --now osbuild-composer.socket
    systemctl enable --now cockpit.socket

# Overriding a system repository
    
Prerequisites:
    You have a custom repository that is accessible from the host system.

Procedure:
    Create a directory where you want to store your repository overrides:

    # sudo mkdir -p /etc/osbuild-composer/repositories
    Copy the file for your distribution from /usr/share/osbuild-composer/ and modify its content.For RHEL 8.7, use /etc/osbuild-composer/repositories/rhel-87.json
    Now restart the osbuild-composer.service
    # sudo systemctl restart osbuild-composer.service

Setup to create Image using Image Builder is completed. Now we will create Image using command line 

# Create Image using command line

The workflow for the command-line interface can be summarized as follows:

    Export (save) the blueprint definition to a plain text file
    Edit this file in a text editor
    Import (push) the blueprint text file back into image builder
    Run a compose to build an image from the blueprint
    Export the image file to download it

Create file with extension .toml. In this repo case we created FIRSTIMAGE-BULEPRINT.toml
Now Push (import) the blueprint:

    # composer-cli blueprints push BLUEPRINT-NAME.toml
    
Verify that the blueprint has been pushed and exists:

    # composer-cli blueprints list
    you will able to see your Buleprint.

Display the blueprint configuration you have just added:

    # composer-cli blueprints show FIRSTIMAGE

Check whether the components and versions listed in the blueprint and their dependencies are valid:

    # composer-cli blueprints depsolve FIRSTIMAGE

If image builder is unable to depsolve a package from your custom repositories, follow the steps:
Remove the osbuild-composer cache:

        # sudo rm -rf /var/cache/osbuild-composer/*
        # sudo systemctl restart osbuild-composer
        
# Creating a system image with image builder in the command-line interface
Procedure:
Start the compose:

        # composer-cli compose start BLUEPRINT-NAME IMAGE-TYPE

Composing images from blueprints

        # composer-cli compose types
        
Currently this are the valid types availables :

        | Description                         | CLI name                   | file extension   
        | ------------------------------------| ---------------------------| --------------|
        |  QEMU QCOW2 Image                   | qcow2                      |  .qcow2       |
        |  TAR Archive                        | tar                        |  .tar         |
        |  Amazon Machine Image Disk          | ami                        |  .ami         |
        |  Azure Disk Image                   | vhd                        |  .vhd         |
        |  Google Cloud Platform              | gce                        |  .vhd         |
        |  VMware Virtual Machine Disk        | vmdk                       |  .vmdk        |
        |  Openstack                          | Openstack                  |  .qcow2       |
        |  RHEL for Edge Commit               | edge-commit                |  .tar         |
        |  RHEL for Edge Container            | edge-container             |  .tar         |
        |  RHEL for Edge Installer            | edge-installer             |  .iso         |
        |  RHEL for Edge Raw                  | edge-raw-image             |  .tar         |
        |  RHEL for Edge Simplified Installer | edge-simplified-installer  |  .iso         |
        |  ISO image                          | image-installer            |  .iso         |
        
Now run the below command to create iso image using our Blueprint

            # composer-cli compose start FIRSTIMAGE image-installer
            output of above command: 
            Compose c1e507cb-ffdf-4564-842a-89e3c2ade65d added to the queue 
            where c1e507cb-ffdf-4564-842a-89e3c2ade65d is the unique UUID of the image creation
After running the command Compose added in the queue you can check the status by running below command.

            # composer-cli compose status
To check Logs

            # composer-cli compose log <build_id>
To download the created image

            # composer-cli compose image COMPOSE-UUID
        
