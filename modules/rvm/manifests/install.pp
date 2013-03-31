define rvm::install (
  $user, # the user to install for
  $ensure="stable"
) {
  include rvm::files
  include curl

  package {
    # rvm complains it wants these packages for ruby1.9.3
  	"libreadline6-dev": ensure => latest;
  	"libsqlite3-dev": ensure => latest;
  	"sqlite3": ensure => latest;	
    "libxml2-dev": ensure => latest;
  	"libxslt1-dev": ensure => latest;
  	"autoconf": ensure => latest;
  	"libgdbm-dev": ensure => latest;
  	"libncurses5-dev": ensure => latest;
  	"automake": ensure => latest;
  	"libtool": ensure => latest;
  	"bison": ensure => latest;
  	"libffi-dev": ensure => latest;
  } 

exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

Exec["apt-update"] -> Package <| |>

  exec {
    "get rvm for $user":
      require => [User[$user], Class["rvm::files"], Class["curl"]],
      command => "bash /usr/bin/bootstrap-rvm.bash $branch",
      user => $user,
      path => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin", "/usr/local/bin" ];
  }
}
