// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title BuyLand
 * @dev Implements buying item
 */
contract TrackItem {
    struct Destination {
        string street;
        string zipCode;
        string country;
    }

    struct Item {
        string itemName;
        Destination currentDestination;
        Destination finalDestination;
    }

    mapping(uint => Item) public items;
    mapping(uint => Destination) public locations;

    uint public itemCount;
    uint public destinationCount;

    constructor() public {
        addDestination("Apartment1", "79401", "US");
        addDestination("Apartment27", "540043", "IND");
    }

    function addDestination(
        string memory _street,
        string memory _zipCode,
        string memory _country
    ) public {
        destinationCount++;
        locations[destinationCount] = Destination(_street, _zipCode, _country);
    }

    function addItem(
        string memory itemName,
        uint currentDestinationId,
        uint finalDestination
    ) public {
        itemCount++;
        items[itemCount] = Item(
            itemName,
            locations[currentDestinationId],
            locations[finalDestination]
        );
    }

    function editItem(uint _id, uint currentDestinationId) public {
        Item memory _item = items[_id];
        items[itemCount] = Item(
            _item.itemName,
            locations[currentDestinationId],
            _item.finalDestination
        );
    }

    function checkReached(uint itemId) public returns (string memory) {
        string memory msg = keccak(
            bytes(items[itemId].currentDestination.street)
        ) == keccak(bytes(items[itemId].finalDestination.street))
            ? "Has reached"
            : "Not reached destination";
        return msg;
    }
}
