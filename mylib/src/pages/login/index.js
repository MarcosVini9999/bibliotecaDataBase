import {useState} from "react";
import {useHistory} from "react-router-dom";
import api from "../../services/shared/api";
import "./style.css";

function Login() {
  const navigate = useHistory();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleLogin = async () => {
    if (!email || !password) {
      alert("email e senha obrigatorios");
    } else {
      try {
        const response = await api.post("/login", {email, password});
        localStorage.setItem("user", response.data);
        navigate.push("/home");
      } catch {
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
