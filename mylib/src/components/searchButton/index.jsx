import './style.css';
import SearchOutlinedIcon from '@mui/icons-material/SearchOutlined';
function SearchButton(props) {
    return (
        <>
            <button className="btnSearch" type="button" onClick={(e) => props.onButtonClick()}>< SearchOutlinedIcon /></button>
        </>
    )
}
export default SearchButton;