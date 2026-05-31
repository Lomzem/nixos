{ inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    users.lomzem = import ./users/lomzem;
  };
}
