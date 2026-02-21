// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract ClawGotchi is ERC721Enumerable, Ownable {
    using Strings for uint256;
    struct Lobster {
        uint256 birthday;
        uint256 lastFed;
        uint256 level;
        bool isHibernating;
    }

    mapping(uint256 => Lobster) public lobsters;
    uint256 public nextTokenId;
    uint256 public constant FEED_INTERVAL = 24 hours;
    uint256 public constant HIBERNATION_TIME = 3 days;

    string public baseTokenURI;

    constructor() ERC721("Claw-Gotchi", "CLAW") Ownable(msg.sender) {}

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseTokenURI = _newBaseURI;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        uint256 level = lobsters[tokenId].level;
        return string(abi.encodePacked(baseTokenURI, Strings.toString(level), ".json"));
    }

    function mint() public {
        uint256 tokenId = nextTokenId++;
        _safeMint(msg.sender, tokenId);
        
        lobsters[tokenId] = Lobster({
            birthday: block.timestamp,
            lastFed: block.timestamp,
            level: 1,
            isHibernating: false
        });
    }

    function feed(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Not your lobster!");
        Lobster storage lobster = lobsters[tokenId];
        
        require(block.timestamp >= lobster.lastFed + 12 hours, "Too full!");
        require(block.timestamp <= lobster.lastFed + HIBERNATION_TIME, "In hibernation, revive first!");

        lobster.lastFed = block.timestamp;
        
        // Эволюция каждые 7 кормлений (условно)
        if (lobster.level < 4) {
            lobster.level++;
        }
    }

    function revive(uint256 tokenId) public payable {
        require(ownerOf(tokenId) == msg.sender, "Not your lobster!");
        require(block.timestamp > lobsters[tokenId].lastFed + HIBERNATION_TIME, "Not hibernating!");
        require(msg.value >= 0.001 ether, "Revive cost: 0.001 ETH");

        lobsters[tokenId].lastFed = block.timestamp;
        lobsters[tokenId].isHibernating = false;
    }

    // Для фронтенда: узнаем состояние
    function getStatus(uint256 tokenId) public view returns (string memory) {
        Lobster memory l = lobsters[tokenId];
        if (block.timestamp > l.lastFed + HIBERNATION_TIME) return "Hibernating";
        if (l.level == 1) return "Egg";
        if (l.level == 2) return "Baby";
        if (l.level == 3) return "Teen";
        return "Base King";
    }
}
