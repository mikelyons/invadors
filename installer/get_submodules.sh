# get_submodules.sh
#    gets all the submodules from github, 
#    NOTE: what if the machine doesn't have git? (use raw and http?)
#
# TODO 
# - update this to place the libs into their proper directories 
# - update libs directory to be organized more cleanly, remove cruft
git clone git@github.com:kikito/middleclass.git
git clone git@github.com:kikito/stateful.lua.git
git clone git@github.com:bakpakin/binser.git