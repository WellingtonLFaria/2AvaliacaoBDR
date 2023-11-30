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


-- Atualizar cliente pelo seu CPF
DELIMITER //
CREATE FUNCTION AtualizarCliente(
    cpf_cliente VARCHAR(11),
    novo_nome_cliente VARCHAR(50),
    novo_email_cliente VARCHAR(40),
    novo_telefone_cliente VARCHAR(11),
    novo_endereco_cliente VARCHAR(50),
    novo_cep_cliente VARCHAR(8),
    nova_senha_cliente VARCHAR(8)
)
RETURNS BOOLEAN
BEGIN
    DECLARE num_rows INT;

    UPDATE Cliente
    SET
        cli_nome = novo_nome_cliente,
        cli_email = novo_email_cliente,
        cli_telefone = novo_telefone_cliente,
        cli_endereco = novo_endereco_cliente,
        cli_cep = novo_cep_cliente,
        cli_senha = nova_senha_cliente
    WHERE cli_cpf = cpf_cliente;

    SET num_rows = ROW_COUNT(); -- Número de linhas afetadas pela atualização

    IF num_rows > 0 THEN
        RETURN TRUE; -- Atualização bem-sucedida
    ELSE
        RETURN FALSE; -- Nenhum registro atualizado
    END IF;
END //
DELIMITER ;


-- Excluir cliente pelo seu CPF
DELIMITER //
CREATE FUNCTION ExcluirCliente(cpf_cliente VARCHAR(11))
RETURNS BOOLEAN
BEGIN
    DECLARE num_rows INT;

    DELETE FROM Cliente WHERE cli_cpf = cpf_cliente;

    SET num_rows = ROW_COUNT();

    -- Verificando se o cliente foi excluído
    IF num_rows > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END //
DELIMITER ;


-- Deletar um suporte pelo seu ID
DELIMITER //
CREATE FUNCTION DeletarSuporte(sup_id INT)
RETURNS BOOLEAN
BEGIN
    DECLARE num_rows INT;

    DELETE FROM Suporte WHERE sup_id = sup_id;

    SET num_rows = ROW_COUNT();

    -- Verificando se o suporte foi excluído
    IF num_rows > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END //
DELIMITER ;
