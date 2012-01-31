package :git, :provides => :scm do
  description 'git scm'
  apt 'git-core'
  requires :git_dependencies

  verify do
    has_executable 'git'
  end
end

package :git_dependencies do
  description 'Git build dependencies'
  apt 'tcl8.4 tk8.4 curl'
end
