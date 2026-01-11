//SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {MinimalAccount} from "../src/ethereum/MinimalAccount.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployMinimalAccount is Script {
    function run() public {
        deployMinimalAccount();
    }

    function deployMinimalAccount() public returns (HelperConfig, MinimalAccount) {
        HelperConfig config = new HelperConfig();
        HelperConfig.NetworkConfig memory netConfig = config.getConfig();

        vm.startBroadcast(netConfig.account);
        MinimalAccount minimalAccount = new MinimalAccount(netConfig.entryPoint);
        minimalAccount.transferOwnership(netConfig.account);
        vm.stopBroadcast();
        return (config, minimalAccount);
    }
}
