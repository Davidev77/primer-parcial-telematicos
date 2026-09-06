#!/bin/bash

URL_BASE="http://parcial.empresa.local"
ARCHIVOS="index.html estilos.css estilos.min.css app.js datos.json grafico.svg lorem.txt foto.jpg paquete.zip"
CONF_DEFLATE="/etc/apache2/mods-available/deflate.conf"
CONF_BROTLI="/etc/apache2/mods-available/brotli.conf"
NIVELES_GZIP="1 6 9"
NIVELES_BROTLI="5 11"

echo "=============================================================="
echo "                 RESULTADOS DE COMPRESIÓN"
echo "=============================================================="

for nivel in $NIVELES_GZIP; do
    sudo sed -i "s/DeflateCompressionLevel [0-9]*/DeflateCompressionLevel $nivel/" "$CONF_DEFLATE"
    sudo systemctl reload apache2

    echo ""
    echo "=============================================================="
    echo "              NIVEL DE COMPRESIÓN GZIP: $nivel"
    echo "=============================================================="

    printf "%-20s %-15s %-12s %-15s %-12s %-10s %-10s\n" "Archivo" "Sin comprimir" "T. sin" "Con gzip" "T. gzip" "Ratio" "Ahorro %"
    printf "%-20s %-15s %-12s %-15s %-12s %-10s %-10s\n" "--------------------" "---------------" "------------" "---------------" "------------" "----------" "----------"

    for f in $ARCHIVOS; do
        sin_resultado=$(curl -s -H 'Accept-Encoding: identity' -o /dev/null -w '%{size_download} %{time_total}' "$URL_BASE/$f")
        sin=$(echo $sin_resultado | cut -d' ' -f1)
        tiempo_sin=$(echo $sin_resultado | cut -d' ' -f2)
        tiempo_sin_ms=$(echo "scale=3; $tiempo_sin * 1000" | bc)

        con=$(curl -s -H 'Accept-Encoding: gzip' -o /dev/null -w '%{size_download} %{time_total}' "$URL_BASE/$f")
        con_size=$(echo $con | cut -d' ' -f1)
        tiempo_con=$(echo $con | cut -d' ' -f2)
        tiempo_con_ms=$(echo "scale=3; $tiempo_con * 1000" | bc)

        ratio=$(echo "scale=3; $con_size/$sin" | bc)
        ahorro=$(echo "scale=1; (1 - $ratio) * 100" | bc)

        printf "%-20s %-15s %-12s %-15s %-12s %-10s %-10s\n" "$f" "${sin} B" "${tiempo_sin_ms} ms" "${con_size} B" "${tiempo_con_ms} ms" "$ratio" "$ahorro%"
    done
done

for calidad in $NIVELES_BROTLI; do
    sudo sed -i "s/BrotliCompressionQuality [0-9]*/BrotliCompressionQuality $calidad/" "$CONF_BROTLI"
    sudo systemctl reload apache2

    echo ""
    echo "=============================================================="
    echo "              CALIDAD DE COMPRESIÓN BROTLI: $calidad"
    echo "=============================================================="

    printf "%-20s %-15s %-12s %-15s %-12s %-10s %-10s\n" "Archivo" "Sin comprimir" "T. sin" "Con Brotli" "T. Brotli" "Ratio" "Ahorro %"
    printf "%-20s %-15s %-12s %-15s %-12s %-10s %-10s\n" "--------------------" "---------------" "------------" "---------------" "------------" "----------" "----------"

    for f in $ARCHIVOS; do
        sin_resultado=$(curl -s -H 'Accept-Encoding: identity' -o /dev/null -w '%{size_download} %{time_total}' "$URL_BASE/$f")
        sin=$(echo $sin_resultado | cut -d' ' -f1)
        tiempo_sin=$(echo $sin_resultado | cut -d' ' -f2)
        tiempo_sin_ms=$(echo "scale=3; $tiempo_sin * 1000" | bc)

        con=$(curl -s -H 'Accept-Encoding: br' -o /dev/null -w '%{size_download} %{time_total}' "$URL_BASE/$f")
        con_size=$(echo $con | cut -d' ' -f1)
        tiempo_con=$(echo $con | cut -d' ' -f2)
        tiempo_con_ms=$(echo "scale=3; $tiempo_con * 1000" | bc)

        ratio=$(echo "scale=3; $con_size/$sin" | bc)
        ahorro=$(echo "scale=1; (1 - $ratio) * 100" | bc)

        printf "%-20s %-15s %-12s %-15s %-12s %-10s %-10s\n" "$f" "${sin} B" "${tiempo_sin_ms} ms" "${con_size} B" "${tiempo_con_ms} ms" "$ratio" "$ahorro%"
    done
done