resource "azurerm_windows_virtual_machine" "storefront" {
    name = format("%s%d", "${var.sf_vm_prefix}", count.index)
    count = 2
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = "${var.sf_vm_size}"
    admin_username      = "${var.sf_admin_user}"
    admin_password      = "${var.sf_admin_pass}"

    network_interface_ids = [azurerm_network_interface.nic[count.index].id, ]

    os_disk {
      caching               = "${var.sf_os_caching}"
      storage_account_type  = "${var.sf_os_storage_type}"
    }

    source_image_reference {
        publisher   = "${var.sf_source_publisher}"
        offer       = "${var.sf_source_offer}"
        sku         = "${var.sf_source_sku}"
        version     = "${var.sf_source_version}"
    }
}


