{
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 24,
            "height": 3,
            "properties": {
                "view": "singleValue",
                "stacked": false,
                "metrics": [
                    [ "CWAgent", "disk_used_percent", "path", "/", "host", "ip-${private_ip}", "device", "xvda1", "fstype", "ext4", { "region": "${region}" } ],
                    [ ".", "mem_used_percent", "host", "ip-${private_ip}", { "region": "${region}" } ],
                    [ ".", "swap_used_percent", ".", ".", { "region": "${region}" } ],
                    [ "AWS/EC2", "CPUUtilization", "InstanceId", "${instance_id}" ]
                ],
                "region": "${region}",
                "period": 300
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
                    [ "CWAgent", "swap_used_percent", "host", "ip-${private_ip}", { "region": "${region}" } ]
                ],
                "region": "${region}",
                "period": 300
            }
        },
        {
            "type": "metric",
            "x": 18,
            "y": 3,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/EC2", "CPUUtilization", "InstanceId", "${instance_id}" ]
                ],
                "region": "${region}"
            }
        }
    ]
}