import './style.css';
import TextField from "@mui/material/TextField";
function SearchBar({ searchTerm, setSearchTerm }) {
    return (
        <>
            <TextField id="outlined-basic" label="Pesquisa" variant="outlined" value={searchTerm} onChange={(e) => {
                setSearchTerm(e.target.value)
            }} />
        </>
    )
}
export default SearchBar;