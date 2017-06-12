## This installation procedure is for native ubuntu/xenial (16.04) 64bits with Virtualbox and vagrant installed

Start by installing git, VirtualBox and Vagrant and set up your ssh connection.

### @Important Leave all default values. No passphrase and the newly generated key must be ~/.ssh/id_rsa

```
ssh-keygen -t rsa -b 4096 -C "your@email.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```
Copy the content of the id_rsa.pub and paste it in github.

Then run:
```
ssh -T git@github.com
```
and accept with yes

Clone the repository `https://github.com/khalid-s/vagrant-vbox-nodejs-ionic`

Go into the newly cloned repository 

```
cd vagrant-vbox-nodejs-ionic
```

Then launch the install bash file 

```
./install.sh
```

Edit your hosts file
```
vim /etc/hosts
```
Add the following lines:
```
192.168.33.10   node.dev
```

Once the installation is complete and if there are no errors, you are good to go

Connect to your vagrant:
```
vagrant ssh
```

You can now open your browser to check your app @ `http://node.dev:8080`

If you have any problem...

```
debug
ask google
```
