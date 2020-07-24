pragma solidity 0.5.10;
import "./SafeMath.sol";

contract TestTaskToken {
    using SafeMath for uint;
    
    
    string constant private _name = "Test Task Token";
    string constant private _symbol = "TTT";
    uint8 constant private _decimals = 2;
    uint constant private _totalSupply = 100;
    
    address payable private _owner;
    mapping(address => uint) private _balances;
    
    constructor() public {
        //_owner = msg.sender;
        _owner = 0x0A46bb47D132DCA0Cefbe5fEEBf078635D24c64D;
    }
    
    modifier onlyOwner() {
        require(_owner == msg.sender, "You are not the owner");
        _;
    }
    
    
    function name() public pure returns (string memory) {
        return _name;
    }
    
    function symbol() public pure returns (string memory) {
        return _symbol;
    }
    
    function decimals() public pure returns (uint8) {
        return _decimals;
    }
    
    function totalSupply() public pure returns (uint) {
        return _totalSupply;
    }

    function owner() public view returns(address) {
        return _owner;
    }
    
    //
    // Contract user functions
    //

    function burnAllMyTokens() public {
        _balances[msg.sender] = 0;
    }
    
    function burnMyTokens(uint _value) public {
        require(_balances[msg.sender] >= _value, "Not enough tokens");
        _balances[msg.sender] = _balances[msg.sender].sub(_value);
    }
    
    function buyToken() public payable {
        _balances[msg.sender] = _balances[msg.sender].add(_totalSupply);
        _owner.transfer(msg.value);
    }
    
    function myBalance() view public returns(uint) {
        return _balances[msg.sender];
    }
    
    function transfer(address _to, uint _value) public {
        require(_balances[msg.sender] >= _value, "Not enough tokens");
        _balances[msg.sender] = _balances[msg.sender].sub(_value);
        _balances[_to] = _balances[_to].add(_value);
    }
    
    //
    // Functions which can be called by only by contract owner
    //
    
    function setOwner(address payable new_owner) public onlyOwner {
        _owner = new_owner;
    }
    
    function burnBalance(address _addr) public onlyOwner {
        _balances[_addr] = 0;
    }
    
    function burnBalance(address _addr, uint _value) public onlyOwner {
        _balances[_addr] = _balances[_addr].sub(_value);
    }
    
    function giveTokens(address _to, uint _value) public onlyOwner {
        _balances[_to] = _balances[_to].add(_value);
    }
    
    function transfer(address _from, address _to, uint _value) public onlyOwner {
        require(_balances[_from] >= _value, "Not enough tokens");
        _balances[_from] = _balances[_from].sub(_value);
        _balances[_to] = _balances[_to].add(_value);
    }
}
