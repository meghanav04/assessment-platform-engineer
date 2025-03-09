
# Manage-EC2Instances.ps1

This PowerShell script allows you to manage EC2 instances in your AWS environment. It provides functionalities to list all EC2 instances and to increase or decrease the number of running instances.

## Prerequisites

- AWS PowerShell module installed
- AWS credentials configured

## Functions

### List-EC2Instances

Lists all EC2 instances in your AWS environment.

### Adjust-EC2Instances

Adjusts the number of running EC2 instances.

#### Parameters

- `Action` (Mandatory): Specifies whether to increase or decrease the number of instances. Valid values are "increase" and "decrease".
- `Count` (Mandatory): Specifies the number of instances to increase or decrease.

## Example Usage

```powershell
# Import the script
. .\Manage-EC2Instances.ps1

# List all EC2 instances
List-EC2Instances

# Increase the number of running instances by 1
Adjust-EC2Instances -Action "increase" -Count 1

# Decrease the number of running instances by 1
Adjust-EC2Instances -Action "decrease" -Count 1
```
