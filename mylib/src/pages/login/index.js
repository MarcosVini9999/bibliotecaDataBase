import {useState} from "react";
import {useHistory} from "react-router-dom";
import api from "../../services/shared/api";
import "./style.css";

import AccountCircleIcon from '@mui/icons-material/AccountCircle';

function Login() {
  const navigate = useHistory();

  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");

  const handleLogin = async () => {
    if (!email || !senha) {
      alert("email e senha obrigatorios");
    } else {
      try {
        const response = await api.post("/login", {email, senha});
        if (response.data.user.tipo_usuario === "Administrador") {
          navigate.push("/homeADM");
        } else {
          if (response.data.user.tipo_usuario === "Bibliotecário") {
            navigate.push("/homeLIB");
          } else {
            navigate.push("/home");
          }
        }
        localStorage.setItem("user", response.data);
        console.log(response.data.user.tipo_usuario);
      } catch {
        alert("Senha ou E-mail incorreto(a)");
      }
    }
  };
  return (
    <div className="estiloLogin">
      <div className="centralizarLogin">   
      <AccountCircleIcon
        classes={{ root: 'userIconEdit' }} 

      />
      <h1 className="letrasLoginTopo">LOGIN</h1>
      </div>
      <p className="textoEmailSuperior">Digite o e-mail:</p>
      <input
        type="text"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="E-mail"
      />
      <p className="textoSenhaSuperior">Digite o senha:</p>
      <input
        type="password"
        value={senha}
        onChange={(e) => setSenha(e.target.value)}
        placeholder="Senha"
      />
      <br></br>
      <button className="buttonEstilo" onClick={handleLogin}>ENTRAR</button>
    </div>
    
  );
}
export default Login;
