import Button from "@mui/material/Button";
import TextField from "@mui/material/TextField";
import {Link} from "react-router-dom";
import "./style.css";

function Login() {
  return (
    <>
      <div className="containerBox">
        <div className="boxLogin">
          <h1 className="loginTitle">LOGIN</h1>
          <div className="containerInput">
            <TextField id="standard-basic" label="E-mail" variant="standard" />
          </div>
          <div className="containerInput">
            <TextField id="standard-basic" label="Senha" variant="standard" />
          </div>
          <div>
            <Link exact to="/home">
              <Button variant="contained">ENTRAR</Button>
            </Link>
          </div>
        </div>
      </div>
    </>
  );
}
export default Login;
