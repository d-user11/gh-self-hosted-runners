{
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 18,
            "height": 3,
            "properties": {
                "view": "singleValue",
                "stacked": false,
                "metrics": [
                    [ "CWAgent", "disk_used_percent", "path", "/", "host", "ip-${private_ip}", "device", "xvda1", "fstype", "ext4" ],
                    [ ".", "mem_used_percent", "host", "ip-${private_ip}" ],
                    [ ".", "swap_used_percent", ".", "." ]
                ],
                "region": "${region}"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 3,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "CWAgent", "disk_used_percent", "path", "/", "host", "ip-${private_ip}", "device", "xvda1", "fstype", "ext4" ]
                ],
                "region": "${region}"
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 3,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "CWAgent", "mem_used_percent", "host", "ip-${private_ip}" ]
                ],
                "region": "${region}"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 3,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "CWAgent", "swap_used_percent", "host", "ip-${private_ip}" ]
                ],
                "region": "${region}"
            }
        }
    ]
}