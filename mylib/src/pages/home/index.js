import {useEffect, useState} from "react";
import api from "../../services/shared/api";
import {Link} from "react-router-dom";
import SearchBar from "../../components/searchBar/index";
import SearchButton from "../../components/searchButton/index";
import List from "../../components/list/index";
import "./style.css";
function Home() {
  const [list, setList] = useState([]);
  const [term, setTerm] = useState("");
  const fetchData = async () => {
    try {
      const result = await api.get(`/livros?query=${term}`);
      setList(result.data);
    } catch {
      setList([]);
    }
  };
  useEffect(() => {
    fetchData();
    //eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
  return (
    <>
      <div className="caixa">
        <Link exact to="/">
          Logout
        </Link>
        <SearchBar searchTerm={term} setSearchTerm={setTerm} />
        <SearchButton onButtonClick={fetchData} />

        {list.length > 0 ? <List list={list} /> : <h3>SEM RESULTADOS</h3>}
      </div>
    </>
  );
}
export default Home;
