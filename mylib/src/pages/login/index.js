import {useState} from "react";
import {useNavigate} from "react-router-dom";
import api from "../../services/shared/api";
import "./style.css";

function Login() {
  const navigate = useNavigate();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const signin = async (email, password) => {
    const response = await api.post("/signin", {email, password});
    return response.data;
  };
  const handleLogin = async () => {
    if (email && password) {
      const isLogged = await signin(email, password);
      if (isLogged) {
        navigate("/");
      } else {
        alert("Senha ou E-mail incorreto(a)");
      }
    }
  };
  return (
    <div>
      <h1>LOGIN</h1>

      <input
        type="text"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="E-mail"
      />
      <input
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        placeholder="Senha"
      />
      <button onClick={handleLogin}>ENTRAR</button>
    </div>
  );
}
export default Login;
