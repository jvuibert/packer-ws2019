# -------------------------------------------------------
# VARIABLES
# -------------------------------------------------------
variable "boot_wait" {
  type    = string
  default = "5s"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "iso_checksum" {
  type    = string
  default = "3022424F777B66A698047BA1C37812026B9714C5"
}

variable "iso_checksum_type" {
  type    = string
  default = "SHA1"
}

variable "iso_url" {
  type    = string
  default = "$${path.cwd}/../../../repository/iso/windows2019/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
}

variable "memsize" {
  type    = string
  default = "2048"
}

variable "numvcpus" {
  type    = string
  default = "2"
}

variable "vm_name" {
  type    = string
  default = "MyWindowsServer2019"
}

variable "winrm_password" {
  type    = string
  default = "ZeP@ssW0rd"
}

variable "winrm_username" {
  type    = string
  default = "Administrator"
}

# -------------------------------------------------------
# SOURCES
# -------------------------------------------------------
source "virtualbox-iso" "windows-server-2019" {
  boot_wait            = "${var.boot_wait}"
  communicator         = "winrm"
  disk_size            = "${var.disk_size}"
  floppy_files         = ["scripts/Autounattend.xml"]
  guest_additions_mode = "disable"
  guest_os_type        = "Windows2016_64"
  headless             = false
  iso_checksum         = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  shutdown_command     = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout     = "30m"
  vboxmanage           = [["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"]]
  vm_name              = "${var.vm_name}"
  winrm_insecure       = true
  winrm_password       = "${var.winrm_password}"
  winrm_timeout        = "4h"
  winrm_use_ssl        = true
  winrm_username       = "${var.winrm_username}"
}

# -------------------------------------------------------
# BUILDERS
# -------------------------------------------------------
build {
  sources = ["source.virtualbox-iso.windows-server-2019"]

  provisioner "file" {
    destination = "C:\\tmp\\readme.txt"
    source      = "files/readme.txt"
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

}
