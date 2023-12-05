-- FUNCTIONS --
-- Formatar CPF
DELIMITER //
CREATE FUNCTION FormatarCPF(cpfSemFormato VARCHAR(11))
RETURNS VARCHAR(14)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE cpfFormatado VARCHAR(14);

    -- Adicionar a formatação ao CPF
    SET cpfFormatado = CONCAT(
        SUBSTRING(cpfSemFormato, 1, 3), '.', 
        SUBSTRING(cpfSemFormato, 4, 3), '.', 
        SUBSTRING(cpfSemFormato, 7, 3), '-', 
        SUBSTRING(cpfSemFormato, 10, 2)
    );

    RETURN cpfFormatado;
END //
DELIMITER ;


-- Formatar telefone
DELIMITER //
CREATE FUNCTION FormatarTelefone(telefone VARCHAR(20))
RETURNS VARCHAR(20)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE telefoneFormatado VARCHAR(20);
    SET telefoneFormatado = CONCAT(
        '(', SUBSTRING(telefone, 1, 2), ') ',
        SUBSTRING(telefone, 3, 4), '-',
        SUBSTRING(telefone, 7, 4)
    );

    RETURN telefoneFormatado;
END //
DELIMITER ;


-- Calcular dias restantes para responder o chamado
DELIMITER //
CREATE FUNCTION DiasRestantesAtePrazo(prazo DATE)
RETURNS INT
DETERMINISTIC
NO SQL
BEGIN
    DECLARE diasRestantes INT;

    SET diasRestantes = DATEDIFF(prazo, CURDATE());

    IF diasRestantes < 0 THEN
        SET diasRestantes = 0;
    END IF;

    RETURN diasRestantes;
END //
DELIMITER ;


-- Busca o nome através do id do usuario e do seu tipo
DELIMITER //
CREATE FUNCTION BuscarNome(id_usuario VARCHAR(11), tipo_usuario VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE nome VARCHAR(255);
    SET nome = "Nome não encontrado!";
    IF tipo_usuario = "cliente" THEN
		SELECT cli_nome INTO nome FROM Cliente WHERE cli_cpf = id_usuario;
	ELSEIF tipo_usuario = "suporte" THEN
		SELECT sup_nome INTO nome FROM Suporte WHERE sup_id = CAST(id_usuario AS SIGNED);
	ELSEIF tipo_usuario = "admin" THEN
		SELECT adm_nome INTO nome FROM Administrador WHERE adm_id = CAST(id_usuario AS SIGNED);
	END IF;
    RETURN nome;
END //
DELIMITER ;


-- Buscar titulo do chamado através de seu ID
DELIMITER //
CREATE FUNCTION BuscarTituloChamado(id_chamado INT)
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE titulo_chamado VARCHAR(255);
    SET titulo_chamado = "Chamado não encontrado!";
    SELECT cham_titulo INTO titulo_chamado FROM Chamado WHERE cham_id = id_chamado;
    RETURN titulo_chamado;
END //
DELIMITER ;


-- Conta quantos chamados o cliente informado abriu
DELIMITER //
CREATE FUNCTION ContarChamados(cliente_cpf VARCHAR(11))
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN (SELECT COUNT(*) FROM Chamado WHERE cham_cli_cpf = cliente_cpf);
END //
DELIMITER ;

-- TESTES --

-- BuscarNome, BuscarTituloChamado
SELECT resp_id AS "ID da resposta", resp_soluc_comum AS "Resposta", 
BuscarNome(resp_sup_id, "suporte") AS "Nome do suporte", 
BuscarTituloChamado(resp_cham_id) AS "Título do chamado" FROM RespostaChamado;

-- ContarChamados, FormatarCPF, FormatarTelefone
SELECT cli_nome AS "Nome do cliente", 
FormatarCPF(cli_cpf) AS "CPF do cliente", 
FormatarTelefone(cli_telefone) AS "Telefone do cliente", 
ContarChamados(cli_cpf) AS "Qtd. de chamados abertos pelo cliente" FROM Cliente;

-- DiasRestantesAtePrazo
SELECT cham_titulo AS "Título do chamado", DiasRestantesAtePrazo(cham_prazo) FROM Chamado;
