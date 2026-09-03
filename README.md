# Microproyecto Integrador: DNS Tolerante a Fallos, Optimización de Tráfico Web y Publicación Segura

**Universidad Autónoma de Occidente**  
**Facultad de Ingeniería**  
**Asignatura:** Servicios Telemáticos  
**Docente:** Oscar H. Mondragón, Ph.D.  
**Semestre:** 2026-02

---

## 👥 Integrantes del Grupo

- **Eddie Santiago Delgado Campo**
- **Sebastian Leiton Goyes**
- **Christian David Home**

---

## 📌 Descripción del Proyecto

Este repositorio contiene la solución completa y reproducible para el **Primer Parcial de Servicios Telemáticos**. El proyecto es un microproyecto práctico integrador compuesto por tres partes fundamentales construidas sobre una infraestructura virtualizada con **Vagrant** y **VirtualBox**:

1. **Parte 1: DNS Tolerante a Fallos con BIND9** (Maestro/Esclavo, Transferencia Segura TSIG, Resolución Inversa, Hardening, Auditoría y Continuidad).
2. **Parte 2: Optimización de Tráfico Web en Apache** (Evaluación comparativa de compresión entre `mod_deflate` y `mod_brotli`).
3. **Parte 3: Publicación Segura a Internet** (Exposición mediante túneles `ngrok`/`cloudflared`, verificación de compresión remota y análisis de seguridad).

## 🚀 Despliegue de la Infraestructura (Reproducibilidad)

### Requisitos Previos

- VirtualBox (v6.1+)
- Vagrant (v2.2+)

### Pasos para Levantar los Entornos

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/parcial-servicios-telematicos.git
   cd parcial-servicios-telematicos
   ```
2. Desplegar las máquinas virtuales:
   ```bash
   vagrant up
   ```
3. Verificar el estado de las VMs:

   ```bash
   vagrant status
   ```

   - **VM1 (Maestro):** `192.168.50.2`
   - **VM2 (Esclavo):** `192.168.50.3`

---

## ⚙️ Detalle de Implementación

### Parte 1: Servidores DNS Maestro/Esclavo (BIND9)

- **Dominio:** `empresa.local`
- **Maestro (VM1):** `192.168.50.2` (`maestro.empresa.local`)
- **Esclavo (VM2):** `192.168.50.3` (`esclavo.empresa.local`)
- **Zona Directa:** Registros `A`, `AAAA`, `CNAME`, `MX`, `NS`.
- **Zona Inversa:** `50.168.192.in-addr.arpa` con registros `PTR`.
- **Seguridad TSIG:** Transferencias de zona restringidas únicamente mediante la clave `esclavo-key` (HMAC-SHA256).
- **Hardening:**
  - Recursión desactivada (`recursion no;`).
  - `allow-query` limitado a la red local (`192.168.50.0/24`).
  - Response Rate Limiting (RRL) configurado (`responses-per-second 10; window 5;`).
- **Auditoría:** Logs independientes en `/var/log/named/` para `queries.log`, `transfers.log` y `security.log`.
- **Pruebas de Continuidad:** Verificación de resolución desde el cliente manteniendo la disponibilidad tras apagar el servidor Maestro (`systemctl stop bind9`).

---

### Parte 2: Compresión Web en Apache (`mod_deflate` vs `mod_brotli`)

- **VirtualHost:** `parcial.empresa.local`
- **Comparación por Algoritmos:**
  - Gzip (`mod_deflate`): Niveles 1, 6 y 9.
  - Brotli (`mod_brotli`): Calidad 5 y 11.
- **Exclusión de Binarios:** Filtros para evitar comprimir recursos ya optimizados/binarios (`.jpg`, `.png`, `.mp4`, `.zip`, `.gz`).
- **Mediciones:** Ratios de compresión, porcentajes de ahorro y uso de CPU/tiempo de respuesta.

---

### Parte 3: Publicación Segura a Internet mediante Túneles

- **Herramienta:** `ngrok`.
- **Página Personalizada:** `pagina_personalizada.html`
- **Verificación Remota:** Comprobación del encabezado `Content-Encoding` (gzip/br) a través del túnel desde redes externas.
- **Análisis de Seguridad:** Identificación de superficie de exposición y mitigaciones aplicadas.
