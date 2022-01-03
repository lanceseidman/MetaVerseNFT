// SPDX-License-Identifier: MIT
// Author: Lance Seidman (@LanceSeidman)
pragma solidity ^0.8.2;
import "../contracts/token/ERC721/ERC721.sol";

contract MetaVerseNFT is ERC721 {
    uint public nextId;

    constructor() ERC721('Teddy Land', 'TDY') {}
    struct LandRecord {
        address owner;
        string name;
        address walletAddress;
    }
    mapping(string => LandRecord) records; 

    modifier onlyOwner(string memory _nextId) {
        if (records[_nextId].owner != msg.sender) revert();
        _;
    }

    function owner(string memory _nextId) public view returns (address ownerAddress) {
        return records[_nextId].owner;
    }

    function setOwner(string memory _nextId, address _newOwner) onlyOwner(_nextId) public returns (bool success) {
        records[_nextId].owner = _newOwner;
        return true;
    }

    function _baseURI() internal pure override returns(string memory) {
        return 'https://oathkey.com/nftverse/teddyland';
    }

    function mint() external payable {
        require(msg.value == 1 ether);
        require(nextId <10000);

        _safeMint(msg.sender, nextId);
        nextId++;
    }
    
    function getWalletAddress(string memory _nextId) public view returns (address walletAddress) {
        return records[_nextId].walletAddress;
    }
}
