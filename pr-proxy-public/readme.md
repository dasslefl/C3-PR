
# Öffentlicher Proxy für den PR

Dieser Proxy wird auf einen öffentlich zugänglichen Server ausgeführt.

## Verwendete Datenrichtungen

### SSH-Tunnel: Erreichbar auf Port 2200
    
    nginx:81
        - /keepalive : Wird regelmäßig gepolled, um zu zeigen dass Pi noch verbunden ist