// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title BuyLand
 * @dev Implements buying asset
 */
contract BuyLand {
    struct Asset {
        string assetNname;
        uint assetValue;
        uint assetId;
    }

    struct Buyer {
        string name;
        uint[] assets;
        uint money;
    }

    mapping(uint => Asset) public assets;
    
    uint[] private _assets;
    uint public assetCount;
    uint public peopleCount;

    mapping(address => Buyer) public people;

    constructor() public {
        addAsset("Apartment1", 1, 67585899);
        addAsset("Apartment2", 2, 5673930);
    }

    function addBuyer(
        address _address,
        string memory _name,
        uint _money
    ) public {
        peopleCount++;
        people[_address] = Buyer(_name, _assets, _money);
    }

    function addAsset(
        string memory _assetName,
        uint _assetValue,
        uint _assetId
    ) public {
        assetCount++;
        assets[assetCount] = Asset(_assetName, _assetValue, _assetId);
    }

    function buy(uint id) public {
        Asset storage asset = assets[id];
        require(
            people[msg.sender].money >= asset.assetValue,
            "You dont have enough cash to buy this asset"
        );

        people[msg.sender].assets.push(asset.assetId);
        people[msg.sender].money -= asset.assetValue;
        delete assets[id];
    }

    function checkBalance() public returns (uint _balance) {
        return _balance = people[msg.sender].money;
    }
}
