 # Target contribution
 
 ## Original TODO list
 
* [x] Introduce Mix.target/0 and Mix.target/1. The default target will be :host
 and it can be set with the MIX_TARGET environment variable;

* [ ] Allow the :target option when specifying dependencies. It will work the
same way as :only, except we will filter on the value of Mix.target rather than Mix.env;
> NOTES: How to approach nested dependencies with different/without target?

* [ ] Allow the --target option in mix deps.get and mix deps.update if someone is
interested in fetching or updating dependencies for a given target;

* [x] Change MixProject.build_path/1 to make the build path be #{target}-#{env}
when the target is not :host;
