# 🖥️ Proxmox VE & ZFS Automation

Bienvenidos a la sala de máquinas de mi Homelab. Este repositorio contiene mis scripts de automatización para domar **Proxmox VE** y gestionar pools de almacenamiento **ZFS** sin tocar la interfaz gráfica (GUI).

Si una tarea requiere más de tres clics, merece ser automatizada.

## 🗂️ Scripts Disponibles

*   📄 `New-ProxmoxVM.ps1`: Script rudo en PowerShell que consume la API REST de Proxmox para aprovisionar Máquinas Virtuales en segundos, montando automáticamente los discos sobre el almacenamiento ZFS.
*   *(Próximamente)* Scripts de Bash para snapshots y replicación automatizada de Datasets ZFS (QuTS hero).
*   *(Próximamente)* Despliegue masivo con cloud-init.

## ⚙️ Requisitos
*   PowerShell 7+ (Compatible con Linux/Windows).
*   Token de API de Proxmox generado (Políticas de mínimos privilegios recomendadas).
*   Storage ZFS configurado en el nodo.

---
*El lado oscuro del Homelab. Mantenido por Marcelo Bugallo (DarthChelo).*
