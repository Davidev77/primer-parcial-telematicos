Vagrant.configure("2") do |config|

  # ---------- VM1: Servidor DNS MAESTRO ----------
  config.vm.define :maestro do |maestro|
    maestro.vm.box = "bento/ubuntu-22.04"
    maestro.vm.hostname = "maestro"
    maestro.vm.network :private_network, ip: "192.168.50.2"

    maestro.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

  # ---------- VM2: Servidor DNS ESCLAVO ----------
  config.vm.define :esclavo do |esclavo|
    esclavo.vm.box = "bento/ubuntu-22.04"
    esclavo.vm.hostname = "esclavo"
    esclavo.vm.network :private_network, ip: "192.168.50.3"

    esclavo.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
  end
end
