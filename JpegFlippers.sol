// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./ContextMixin.sol";

contract JpegFlippers is Ownable, ERC721Enumerable, ContextMixin {
  using Strings for uint256;

  string private _tokenBaseURI;
  string private baseExtension = ".json";
  uint256 private maxSupply = 40000;

  constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI
  ) ERC721(_name, _symbol) {
    _tokenBaseURI = _initBaseURI;
  }

  function mintBatch(address _to, uint256 _amount) public onlyOwner {
    uint256 supply = totalSupply();
    require(_amount > 0);
    require(supply + _amount <= maxSupply);

    for (uint256 i = 1; i <= _amount; i++) {
      _safeMint(_to, supply + i);
    }
  }

  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

    string memory baseURI = _baseURI();
    return bytes(baseURI).length > 0
        ? string(abi.encodePacked(baseURI, tokenId.toString(), baseExtension))
        : "";
  }

  function isApprovedForAll(address _owner, address _operator) public view override returns (bool isOperator) {
    if (_operator == address(                       )) {
    
      return true;
    }

    return ERC721.isApprovedForAll(_owner, _operator);
  }

  function _msgSender() internal view override returns (address sender) {
    return ContextMixin.msgSender();
  }

  function _baseURI() internal view override returns (string memory) {
    return _tokenBaseURI;
  }
}
