



resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = "${azurerm_resource_group.main.location}"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  network_interface_ids = ["${azurerm_network_interface.main.id}"]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

    // az vm image list --output table
    storage_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "18.04-LTS"
        version = "latest"
    }

    storage_os_disk {
        name = "myosdisk1"
        caching = "ReadWrite"
        create_option = "FromImage"

    }

    // Stated as optional but is actually required
    os_profile {
        computer_name = "rubelguf"
        admin_username = "dude"
    }
    os_profile_linux_config {
        disable_password_authentication = "true"
        ssh_keys {
            key_data = file("~/.ssh/id_rsa.pub")
            path = "/home/dude/.ssh/authorized_keys"
        } 
    }

}