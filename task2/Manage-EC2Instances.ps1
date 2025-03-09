
# Import AWS PowerShell module
Import-Module AWSPowerShell

# Function to list all EC2 instances
function List-EC2Instances {
    $instances = Get-EC2Instance
    foreach ($instance in $instances.Instances) {
        Write-Output "Instance ID: $($instance.InstanceId), State: $($instance.State.Name)"
    }
}

# Function to adjust the number of running EC2 instances
function Adjust-EC2Instances {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("increase", "decrease")]
        [string]$Action,
        
        [Parameter(Mandatory=$true)]
        [int]$Count
    )

    $instances = Get-EC2Instance | Where-Object { $_.State.Name -eq "running" }
    $runningCount = $instances.Instances.Count

    if ($Action -eq "increase") {
        for ($i = 0; $i -lt $Count; $i++) {
            # Launch a new instance (assuming the same configuration as the existing instances)
            $newInstance = New-EC2Instance -ImageId "ami-0c02fb55956c7d316" -InstanceType "t3.medium" -KeyName "your-key-pair" -SecurityGroupIds "your-security-group-id"
            Write-Output "Launched new instance: $($newInstance.Instances.InstanceId)"
        }
    } elseif ($Action -eq "decrease" -and $runningCount -gt $Count) {
        for ($i = 0; $i -lt $Count; $i++) {
            $instanceId = $instances.Instances[$i].InstanceId
            Stop-EC2Instance -InstanceId $instanceId
            Write-Output "Stopped instance: $instanceId"
        }
    } else {
        Write-Output "Cannot decrease instances below the current running count."
    }
}

# Example usage
List-EC2Instances
Adjust-EC2Instances -Action "increase" -Count 1
