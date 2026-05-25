#!/bin/bash
# =============================================================================
#  GPU info — para waybar y monitorización rápida
# =============================================================================

if command -v nvidia-smi &> /dev/null; then
    nvidia-smi --query-gpu=temperature.gpu,utilization.gpu,memory.used,memory.total \
        --format=csv,noheader,nounits | awk -F', ' '{
            printf "{\"text\": \" 󰢮 %d%% %d°C | %d/%d MB\", \"class\": \"gpu\"}",
            $2, $1, $3, $4
        }'
else
    echo '{"text": " 󰢮 N/A", "class": "gpu"}'
fi
