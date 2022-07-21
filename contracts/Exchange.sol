//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./Token.sol";

contract Exchange {
    address public feeAccount;
    uint256 public feePercent;
    mapping(address => mapping(address => uint256)) public tokens; // for each token, tracks holder addresses and their balances
    mapping(uint256 => _Order) public orders; // Orders Mapping
    uint256 public orderCount; 
    mapping(uint256 => bool) public orderCancelled;
    

    event Deposit(
        address token, 
        address user, 
        uint256 amount, 
        uint256 balance
    );

    event Withdraw(
        address token, 
        address user, 
        uint256 amount, 
        uint256 balance
    );

    event Order(
        uint256 id,
        address user,
        address tokenGet,
        uint256 amountGet,
        address tokenGive,
        uint256 amountGive, 
        uint256 timestamp
    );

    event Cancel(
        uint256 id,
        address user,
        address tokenGet,
        uint256 amountGet,
        address tokenGive,
        uint256 amountGive, 
        uint256 timestamp
    );

    // A way to model the order
    struct _Order {
        // Attributes of an order
        uint256 id; // Unique identifier for order
        address user; // User who made order
        address tokenGet; // Address of the token they receive
        uint256 amountGet; // Amount they receive
        address tokenGive; // Address of token they give
        uint256 amountGive; // Amount they give
        uint256 timestamp; // When order was created
    }

    constructor(address _feeAccount, uint256 _feePercent) {
        feeAccount = _feeAccount;
        feePercent = _feePercent;
    }

    // Deposit Tokens
    function depositToken(
        address _token, 
        uint256 _amount
    )  public  {
        // Transfer tokens to exchange
        require(Token(_token).transferFrom(msg.sender, address(this), _amount));
        // Update user balance
        tokens[_token][msg.sender] = tokens[_token][msg.sender] + _amount;
        // emit an event
        emit Deposit(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }

    function withdrawToken(
        address _token, 
        uint256 _amount
    ) public {
        // Update user balance
        require(Token(_token).transfer(msg.sender, _amount));
        // Transfer tokens to user
        tokens[_token][msg.sender] = tokens[_token][msg.sender] - _amount;
        // Emit an event
        emit Withdraw(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }

    // Check Balances
    function balanceOf(address _token, address _user)
        public
        view
        returns (uint256) 
    {
        return tokens[_token][_user];
    }

    // --------------------
    // Make & Cancel Orders

    // Token Give (the token they want to spend) - which token, and how much?
    // Token Get (the token they want to receive) - which token, and how much?

    function makeOrder(
        address _tokenGet,
        uint256 _amountGet,
        address _tokenGive,
        uint256 _amountGive
    ) public {

        // Require token balance
        require(balanceOf(_tokenGive, msg.sender) >= _amountGive);


        // CREATE ORDER
        orderCount = orderCount +1;
        orders[orderCount] = _Order(
            orderCount, // id
            msg.sender, // user
            _tokenGet, // tokenGet
            _amountGet, // amountGet
            _tokenGive, // tokenGive
            _amountGive, // amountGive
            block.timestamp // timestamp
        );

        // Emit event
        emit Order(
            orderCount,
            msg.sender,
            _tokenGet,
            _amountGet,
            _tokenGive,
            _amountGive,
            block.timestamp
        );
    }

    function cancelOrder(
        uint256 _id
    ) public {
        // Fetch order
        _Order storage _order = orders[_id]; // pulls out the order from orders struct with id of _id and assigns it to _order
       
        require(address(_order.user) == msg.sender); // Ensure the caller of the function is the owner of the order
        require(_order.id == _id); // Order must exist
        
        orderCancelled[_id] = true; // Cancel the order

        // Emit event
        emit Cancel(
            _order.id,
            msg.sender,
            _order.tokenGet,
            _order.amountGet,
            _order.tokenGive,
            _order.amountGive,
            block.timestamp
        );
    }

}
