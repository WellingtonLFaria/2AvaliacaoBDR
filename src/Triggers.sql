-- TRIGGERS --

-- Trigger ao responder chamado
DELIMITER //

CREATE TRIGGER ResponderChamado
AFTER INSERT ON RespostaChamado
FOR EACH ROW
BEGIN
    UPDATE Chamado
    SET status = 'Em andamento'
    WHERE cham_id = NEW.resp_cham_id;
END //

DELIMITER ;


-- Trigger ao deletar chamado
DELIMITER //

CREATE TRIGGER DeletarChamado
AFTER DELETE ON Chamado
FOR EACH ROW
BEGIN
    DELETE FROM RespostaChamado
    WHERE resp_cham_id = OLD.cham_id;
END //

DELIMITER ;


-- Trigger ao deletar resposta de chamado
DELIMITER //

CREATE TRIGGER DeletarRespostaChamado
AFTER DELETE ON RespostaChamado
FOR EACH ROW
BEGIN
    UPDATE Chamado
    SET status = 'Aberto'
    WHERE cham_id = OLD.resp_cham_id;
END //

DELIMITER ;


-- Trigger ao deletar cliente
DELIMITER //

CREATE TRIGGER DeletarCliente
AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
    DELETE FROM Chamado
    WHERE cham_cli_id = OLD.cli_id;
END //

DELIMITER ;


-- Trigger ao deletar suporte
DELIMITER //

CREATE TRIGGER DeletarSuporte
AFTER DELETE ON Suporte
FOR EACH ROW
BEGIN
    DELETE FROM RespostaChamado
    WHERE resp_sup_id = OLD.sup_id;
END //

DELIMITER ;


-- Trigger ao atualizar chamado
DELIMITER //

CREATE TRIGGER AtualizarChamado
AFTER UPDATE ON Chamado
FOR EACH ROW
BEGIN
    IF NEW.cham_prazo < CURDATE() THEN
        UPDATE Chamado
        SET cham_status = 'Atrasado'
        WHERE cham_id = NEW.cham_id;
    END IF;
END //

DELIMITER ;
