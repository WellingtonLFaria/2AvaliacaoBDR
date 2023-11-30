use callgenie;

-- PROCEDURES --

-- Conta a quantidade de cada tipo de status de chamado
DELIMITER //

CREATE PROCEDURE ContarStatusChamados()
BEGIN
    DECLARE aberto INT;
    DECLARE andamento INT;
    DECLARE concluido INT;
    DECLARE atrasado INT;
    
    SELECT COUNT(*) INTO aberto FROM Chamado WHERE cham_status = "Aberto";
    SELECT COUNT(*) INTO andamento FROM Chamado WHERE cham_status = "Em Andamento";
    SELECT COUNT(*) INTO concluido FROM Chamado WHERE cham_status = "Concluído";
    SELECT COUNT(*) INTO atrasado FROM Chamado WHERE cham_status = "Atrasado";
    
    
    SELECT aberto AS 'Chamados abertos', andamento AS 'Chamados em andamento', concluido AS 'Chamados concluídos', atrasado AS 'Chamados em atraso';
    
END //

DELIMITER ;


-- Conta a quantidade de cada tipo de urgência de chamado
DELIMITER //

CREATE PROCEDURE ContarUrgenciaChamados()
BEGIN
    DECLARE baixa INT;
    DECLARE media INT;
    DECLARE alta INT;
    DECLARE urgente INT;
    
    SELECT COUNT(*) INTO baixa FROM Chamado WHERE cham_urgencia = "baixa";
    SELECT COUNT(*) INTO media FROM Chamado WHERE cham_urgencia = "media";
    SELECT COUNT(*) INTO alta FROM Chamado WHERE cham_urgencia = "alta";
    SELECT COUNT(*) INTO urgente FROM Chamado WHERE cham_urgencia = "urgente";
    
    
    SELECT baixa AS 'Chamados de baixa urgência', media AS 'Chamados de média urgência', alta AS 'Chamados de alta urgência', urgente AS 'Chamados urgentes';
    
END //

DELIMITER ;


-- Inserir resposta a um chamado
DELIMITER //

CREATE PROCEDURE InserirRespostaChamado(
	IN in_solucao VARCHAR(255),
    IN in_sup_id INT,
    in in_cham_id INT
)
BEGIN
	DECLARE hoje DATE;
	SET hoje = CURDATE();
	INSERT INTO RespostaChamado (resp_soluc_comum, resp_data, resp_sup_id, resp_cham_id) VALUES (in_solucao, hoje, in_sup_id, in_cham_id);
    SELECT * FROM RespostaChamado WHERE resp_cham_id = in_cham_id;
    UPDATE Chamado SET cham_status = 'Em andamento' WHERE cham_id = in_cham_id;
END //

DELIMITER ;


-- Deletar chamado pelo seu respectivo ID
DELIMITER //

CREATE PROCEDURE DeletarChamado(
	IN in_cham_id INT
)
BEGIN
	DELETE FROM chamado WHERE cham_id = in_cham_id;
    SELECT "Chamado deletado com sucesso!";
END //

DELIMITER ;


-- Atualizar os status dos chamados para atrasado se estiverem passado do prazo
DELIMITER //

CREATE PROCEDURE AtualizarStatusAtrasado()
BEGIN
	DECLARE hoje DATE;
    SET hoje = CURDATE();
	UPDATE Chamado SET cham_status = "Em atraso" WHERE cham_prazo < hoje;
END //

DELIMITER ;

DELIMITER //

-- Atualizar telefone do usuário informado
CREATE PROCEDURE AtualizarTelefone(
	IN tipo_usuario VARCHAR(30),
    IN id_usuario INT,
	IN telefone VARCHAR(11)
)
BEGIN
	IF tipo_usuario = 'suporte' THEN
		UPDATE Suporte SET sup_telefone = telefone WHERE sup_id = id_usuario;
	ELSEIF tipo_usuario = 'cliente' THEN
		UPDATE Cliente SET cli_telefone = telefone WHERE cli_id = id_usuario;
	ELSE
		SELECT "Tipo de usuário desconhecido!";
	END IF;
END //

DELIMITER ;


-- TESTES --

-- CALL ContarStatusChamados();
-- CALL ContarUrgenciaChamados();
-- CALL AtualizarStatusAtrasado();
-- CALL InserirRespostaChamado("Só ligar", 1, 1);
-- CALL DeletarChamado(2);
-- CALL AtualizarTelefone('suporte', 1, '12999990123');