-- TRIGGERS --

-- Trigger ao responder chamado
DELIMITER //
CREATE TRIGGER ResponderChamado
AFTER INSERT ON RespostaChamado
FOR EACH ROW
BEGIN
    UPDATE Chamado
    SET cham_status = 'Em andamento'
    WHERE cham_id = NEW.resp_cham_id;
END //
DELIMITER ;


-- Trigger ao atualizar uma resposta de chamado
DELIMITER //
CREATE TRIGGER AtualizarResposta
BEFORE UPDATE ON RespostaChamado
FOR EACH ROW
BEGIN
	SET NEW.resp_data = NOW();
END //
DELIMITER ;


-- Trigger ao inserir um chamado
DELIMITER //
CREATE TRIGGER SetChamadoDataInicio
BEFORE INSERT ON Chamado
FOR EACH ROW
BEGIN
    SET NEW.cham_data_inicio = CURDATE();
END //
DELIMITER ;


-- Trigger ao atualizar um chamado
DELIMITER //
CREATE TRIGGER SetChamadoDataFim
BEFORE UPDATE ON Chamado
FOR EACH ROW
BEGIN
    IF NEW.cham_status = 'Concluído' THEN
        SET NEW.cham_data_fim = CURDATE();
    END IF;
END //
DELIMITER ;


-- Trigger ao inserir uma resposta
DELIMITER //
CREATE TRIGGER SetChamadoPrazo
BEFORE INSERT ON Chamado
FOR EACH ROW
BEGIN
    SET NEW.cham_prazo = DATE_ADD(CURDATE(), INTERVAL 3 DAY);
END //
DELIMITER ;


-- Trigger ao inserir um chamado
DELIMITER //
CREATE TRIGGER SetChamadoStatus
BEFORE UPDATE ON Chamado
FOR EACH ROW
BEGIN
    SET NEW.cham_status = 'Aberto';
END //
DELIMITER ;

-- Resultado ResponderChamado
INSERT INTO RespostaChamado(resp_soluc_comum, resp_sup_id, resp_cham_id) VALUES ("Teste", 5, 4);
SELECT * FROM Chamado;

-- Resultado AtualizarResposta
UPDATE RespostaChamado SET resp_soluc_comum = "Teste" WHERE resp_id = 2;
SELECT * FROM RespostaChamado WHERE resp_id = 2;

-- Resultado SetChamadoDataInicio
INSERT INTO Chamado(cham_titulo, cham_descricao, cham_urgencia, cham_cli_cpf) VALUES ("Problemas na máquina", "Problema com o S.O.", "baixa", 12345678901);
SELECT * FROM Chamado;

-- Resultado SetChamadoDataFim
UPDATE Chamado SET cham_status = "Concluído" WHERE cham_id = 5;
SELECT * FROM Chamado;

-- Resultado SetRespostaData
INSERT INTO RespostaChamado(resp_soluc_comum, resp_sup_id, resp_cham_id) VALUES ("Teste", 5, 5);
SELECT * FROM RespostaChamado;