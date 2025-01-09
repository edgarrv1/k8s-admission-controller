# Context
The following repository holds some of the building blocks to create an admission controller in Kubernetes. This is my attempt of creating a very simple admission controller of the validation type. It was done for the purpose of going a bit beyond of the scope of my Linux Foundation Certified Kubernetes Security Specialist (CKS) certification. 

# Admission Controller Spec
The admission controller is simply checking to see if a container in a deployment is running as root or more specifically as the UID - 0. 

# Kubernetes Documentation
- [Admission Controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/)
