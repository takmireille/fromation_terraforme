terraform {

  required_providers {

    docker = {

      source  = "kreuzwerker/docker"

      version = "~> 3.0.1"

    }

  }

}


provider "docker" {

  host = "npipe:////.//pipe//docker_engine"

}

resource "docker_network" "private_network" {
  name = "my_network"
}

resource "docker_volume" "shared_volume" {
  name = "shared_volume"

  #volumes {     
    #container_path = "/shared"     
    #host_path      = C/Users/Administrateur/Desktop/volume
     }



resource "docker_container""controller"{
  name    = "controller"
  image   = "ubuntu"
  network_mode = docker_network.private_network.name
  command = ["tail", "-f","/dev/null"]
  #volume = docker_volume
}

resource "docker_container" "target1" {
  name    = "target1"
  image   = "ubuntu"
  network_mode = docker_network.private_network.name
  command = ["tail","-f", "/dev/null"]
  #volumes {     
    #container_path = "\shared"     
    #host_path      = C:\Users\Administrateur\Desktop\volume
    }
  #command        = ["tail", "/dev/null"]


resource "docker_container" "target2" {
  name    = "target2"
  image   = "ubuntu"
  network_mode = docker_network.private_network.name
  command = ["tail" , "-f" , "/dev/null"]
  #volumes = [docker_volume.shared_volume + ":/data"]
}

# Provisionneur remote-exec pour exécuter la commande
resource "null_resource" "exec_bootstrap" {
  depends_on = [
    docker_container.controller,
    docker_container.target1,
    docker_container.target2,
  ]

  connection {
    type     = "ssh"
    user     = "root"  
    password = "toto"  
}

  provisioner "remote-exec" {
    inline = [
      "docker exec controller bootstrap.sh",
      "docker exec target1 bootstrap.sh",
      "docker exec target2 bootstrap.sh",
    ]
  }
}
