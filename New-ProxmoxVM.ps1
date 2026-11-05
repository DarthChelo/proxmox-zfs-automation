<#
.SYNOPSIS
    🔥 Aprovisionamiento automatizado de VMs en Proxmox VE sobre ZFS.
.DESCRIPTION
    Script para crear Máquinas Virtuales consumiendo la API REST de Proxmox.
    Autor: Marcelo Bugallo (DarthChelo)
    Homelab R&D: Proxmox + ZFS
#>

param (
    [Parameter(Mandatory=$true)][string]$VmName,
    [Parameter(Mandatory=$true)][int]$VmId,
    [int]$Memory = 2048,
    [int]$Cores = 2,
    [string]$Storage = "local-zfs"
)

# Configuración del entorno (Ajustar IPs y Tokens de tu Homelab)
$ProxmoxHost = "https://192.168.100.10:8006/api2/json"
$ApiTokenId = "root@pam!automation"
$ApiTokenSecret = "PON_TU_SECRETO_AQUI"

# Ignorar errores de certificado autofirmado para el entorno de laboratorio local
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

$Headers = @{
    "Authorization" = "PVEAPIToken=$ApiTokenId=$ApiTokenSecret"
}

Write-Host "[*] Contactando al Hypervisor (Proxmox VE API)..." -ForegroundColor Cyan

# Definición de la estructura de la VM (Network, Disco SCSI en ZFS, OS Linux)
$Body = @{
    vmid   = $VmId
    name   = $VmName
    memory = $Memory
    cores  = $Cores
    net0   = "virtio,bridge=vmbr0"
    scsihw = "virtio-scsi-pci"
    scsi0  = "$($Storage):32"
    ostype = "l26"
}

try {
    # Llamada POST para crear la VM
    $Response = Invoke-RestMethod -Uri "$ProxmoxHost/nodes/pve/qemu" -Method Post -Headers $Headers -Body $Body
    Write-Host "[+] VM $VmName (ID: $VmId) aprovisionada exitosamente en el pool $Storage." -ForegroundColor Green
} catch {
    Write-Host "[-] Error al desplegar la VM: $_" -ForegroundColor Red
}
