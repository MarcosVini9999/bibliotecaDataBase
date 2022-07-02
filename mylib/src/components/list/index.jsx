import Accordion from '@mui/material/Accordion';
import AccordionSummary from '@mui/material/AccordionSummary';
import AccordionDetails from '@mui/material/AccordionDetails';
import Typography from '@mui/material/Typography';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
function List({ list }) {
    return (
        <>
            {list.map((book, index) => (
                <Accordion>
                    <AccordionSummary
                        expandIcon={<ExpandMoreIcon />}
                        aria-controls="panel1a-content"
                        id="panel1a-header"
                    >
                        <Typography>{book.titulo}</Typography>
                    </AccordionSummary>
                    <AccordionDetails>
                        <Typography>
                            <div>
                                <p>Autor:{book.author}</p>
                                <p>ISBN::{book.ISBN}</p>
                                <p>Ano de Lançamento:{book.ano_lançamento}</p>
                                <p>Editora:{book.editora}</p>
                                <p>Cópias:{book.qtd_copias}</p>
                                <p>Categoria:{book.categoria}</p>
                                <p>Descrição:{book.descricao}</p>
                            </div>
                        </Typography>
                    </AccordionDetails>
                </Accordion>
            ))}
        </>
    )
}
export default List;