# Projet Cloud – Terraform + Ansible (Azure)

Ce projet déploie sur Azure :
- une VM Ubuntu 22.04,
- un stockage Blob,
- un backend Node.js (port 8080) configuré avec Ansible.

## Prérequis

- Terraform (>= 1.x)
- Azure CLI (`az`) connecté à votre compte
- Ansible (sur WSL/Linux recommandé)
- Une paire de clés SSH (`~/.ssh/id_rsa` et `~/.ssh/id_rsa.pub`)

## Installation

1. Cloner le projet et se placer dans le dossier.
2. Vérifier les variables dans `terraform.tfvars`.
3. Se connecter à Azure :

```powershell
az login
az account set --subscription "<VOTRE_SUBSCRIPTION_ID_OU_NOM>"
```

4. Initialiser Terraform :

```powershell
terraform init
```

## Utilisation

### 1) Déployer l'infrastructure

```powershell
terraform plan
terraform apply -auto-approve
```

Récupérer l'IP publique de la VM (sans terraform output) :

```powershell
az vm list-ip-addresses --resource-group rg-mon-projet --name mon-projet-vm --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv
```

### 2) Configurer la VM avec Ansible

Le playbook dépend de la variable d’environnement `AZURE_STORAGE_CONNECTION_STRING`.

1. Définir la chaîne de connexion du Storage Account (depuis Azure Portal ou Azure CLI) :

```powershell
$env:AZURE_STORAGE_CONNECTION_STRING = "<VOTRE_CONNECTION_STRING_AZURE_BLOB>"
```

2. Mettre l’IP de la VM dans `ansible/inventory.ini`.

3. Lancer Ansible (depuis un environnement Ansible fonctionnel) :

```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```

### 3) Tester l’API

Base URL : `http://<VM_PUBLIC_IP>:8080`

- Lister les fichiers :

```bash
curl http://<VM_PUBLIC_IP>:8080/files
```

- Uploader un fichier :

```bash
curl -X POST http://<VM_PUBLIC_IP>:8080/upload \
	-H "Content-Type: application/json" \
	-d '{"filename":"test.txt","content":"Bonjour"}'
```

- Télécharger un fichier :

```bash
curl http://<VM_PUBLIC_IP>:8080/files/test.txt
```

- Supprimer un fichier :

```bash
curl -X DELETE http://<VM_PUBLIC_IP>:8080/files/test.txt
```

### 4) Connexion SSH à la VM

```powershell
ssh adminuser@<VM_PUBLIC_IP>
```

Si vous voyez `REMOTE HOST IDENTIFICATION HAS CHANGED`, supprimez l’ancienne empreinte puis reconnectez-vous :

```powershell
ssh-keygen -R <VM_PUBLIC_IP> -f "$HOME/.ssh/known_hosts"
ssh adminuser@<VM_PUBLIC_IP>
```

## Nettoyage

Pour supprimer toutes les ressources Azure créées :

```powershell
terraform destroy -auto-approve
```
