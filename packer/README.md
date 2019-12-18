# Building AMIs
The AMIs are based on Amazon Linux 2 and are encrypted.

## Jenkins Server
Create `variables.json` from `variables.json.template` and customize the values

```
cp variables.json.template jenkins-amzn2/variable.json
```

Build the AMI

```
cd jenkins-amzn2
packer build -var-file variables.json jenkins-amzn2.json
```

## Jenkins Agent
Create `variables.json` from `variables.json.template` and customize the values

```
cp variables.json.template agent-amzn2/variable.json
```

Build the AMI

```
cd agent-amzn2
packer build -var-file variables.json agent-amzn2.json
```