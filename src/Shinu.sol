import {ERC20} from "@openzepplin/contracts/token/ERC20.sol";
import { Ownable } from "@openzepplin/contracts/access/Ownable.sol";

contract Shinu is ERC20, Ownable {
    constructor() ERC20("Shinu", "SHI") {}

    function mint(address _to, uint amount) public isOwner {
        _mint(_to, amount);
    }

    function burn(address _to , uint amount) public {
        _burn(_to, amount);
    }
}
