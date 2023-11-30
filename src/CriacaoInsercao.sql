-- Criação --
create database callgenie;
use callgenie;
 
-- Tabelas --
-- tabela Cliente
CREATE TABLE Cliente (
    cli_nome VARCHAR(50) NOT NULL,
    cli_cpf VARCHAR(11) NOT NULL PRIMARY KEY,
    cli_email VARCHAR(40) NOT NULL,
    cli_telefone VARCHAR(11),
    cli_endereco VARCHAR(50),
    cli_cep VARCHAR(8),
    cli_senha VARCHAR(8)
);
 
-- tabela Chamado
CREATE TABLE Chamado (
    cham_id INT AUTO_INCREMENT PRIMARY KEY,
    cham_titulo VARCHAR(30) NOT NULL,
    cham_descricao VARCHAR(100),
    cham_status ENUM('Aberto', 'Em Andamento', 'Concluído', 'Em atraso') DEFAULT 'Aberto',
    cham_data_inicio DATE,
    cham_urgencia ENUM('baixa', 'media', 'alta', 'urgente') NOT NULL DEFAULT 'media',
    cham_prazo DATE,
    cham_cli_cpf VARCHAR(11),
    FOREIGN KEY (cham_cli_cpf) REFERENCES Cliente(cli_cpf)
);
 
-- tabela Administrador
CREATE TABLE Administrador (
    adm_id INT AUTO_INCREMENT PRIMARY KEY,
    adm_nome VARCHAR(30) NOT NULL,
    adm_telefone CHAR(11),
    adm_email VARCHAR(40) NOT NULL,
    adm_senha VARCHAR(8)
);
 
-- tabela Suporte
CREATE TABLE Suporte (
    sup_id INT AUTO_INCREMENT PRIMARY KEY,
    sup_cpf VARCHAR(11) NOT NULL UNIQUE,
    sup_nome VARCHAR(40) NOT NULL,
    sup_email VARCHAR(40) NOT NULL,
    sup_telefone VARCHAR(11),
    sup_senha VARCHAR(8) NOT NULL
);
 
-- tabela RespostaChamado
CREATE TABLE RespostaChamado (
    resp_id INT AUTO_INCREMENT PRIMARY KEY,
    resp_soluc_comum VARCHAR(255) NOT NULL,
    resp_data DATE,
    resp_sup_id INT,
    resp_cham_id INT,
    FOREIGN KEY (resp_sup_id) REFERENCES Suporte(sup_id),
    FOREIGN KEY (resp_cham_id) REFERENCES Chamado(cham_id)
);
 
-- tabela Equipamento
CREATE TABLE Equipamento (
    equ_id INT AUTO_INCREMENT PRIMARY KEY,
    equ_nome VARCHAR(255),
    equ_numserie VARCHAR(255),
    equ_tipo VARCHAR(255),
    equ_cham_id INT,
    equ_sup_id INT,
    FOREIGN KEY (equ_cham_id) REFERENCES Chamado(cham_id),
    FOREIGN KEY (equ_sup_id) REFERENCES RespostaChamado(resp_sup_id)
);
 
--  tabela Faq
CREATE TABLE Faq (
    faq_id INT AUTO_INCREMENT PRIMARY KEY,
    faq_pergunta VARCHAR(100) NOT NULL,
    faq_resposta VARCHAR(500) NOT NULL,
    faq_sup_id INT,
    FOREIGN KEY (faq_sup_id) REFERENCES Suporte(sup_id)
);
 
-- Criação do usuário admin, se ainda não existir
INSERT INTO Administrador (adm_nome, adm_telefone, adm_email, adm_senha)
VALUES ('admin', '12997881456', 'emaildoadm@callgenie.com', 'fatec')
ON DUPLICATE KEY UPDATE adm_nome=VALUES(adm_nome);
 
 
-- Inserções Cliente
 
INSERT INTO Cliente (cli_nome, cli_cpf, cli_email, cli_telefone, cli_endereco, cli_cep, cli_senha)
VALUES ('João', '12345678901', 'joao@gmail.com', '12997881456', 'Rua 1', '12345678', '12345678'),
('Maria', '12345678902', 'maria@gmail.com', '12997881457', 'Rua 2', '12345679', '12345679'),
('José', '12345678903', 'jose@gmail.com', '12997881458', 'Rua 3', '12345670', '12345670'),
('Ana', '12345678904', 'ana@gmail.com', '12997881459', 'Rua 4', '12345671', '12345671'),
('Pedro', '12345678905', 'pedro@gmail.com', '12997881450', 'Rua 5', '12345672', '12345672'),
('Paula', '12345678906', 'paula@gmail.com', '12997881451', 'Rua 6', '12345673', '12345673'),
('Carlos', '12345678907', 'carlos@gmail.com', '12997881452', 'Rua 7', '12345674', '12345674'),
('Camila', '12345678908', 'camila@gmail.com', '12997881453', 'Rua 8', '12345675', '12345675'),
('Fernando', '12345678909', 'fernando@gmail.com', '12997881454', 'Rua 9', '12345676', '12345676'),
('Fernanda', '12345678910', 'fernanada@gmail.com', '12997881455', 'Rua 10', '12345677', '12345677'),
('Rafael', '12345678911', 'rafael@gmail.com', '12997881460', 'Rua 11', '12345680', '12345680'),
('Rafaela', '12345678912', 'rafaela@gmail.com', '12997881461', 'Rua 12', '12345681', '12345681'),
('Gabriel', '12345678913', 'gabriel@gmail.com', '12997881462', 'Rua 13', '12345682', '12345682'),
('Gabriela', '12345678914', 'gabriela@gmail.com', '12997881463', 'Rua 14', '12345683', '12345683'),
('Mariana', '12345678915', 'mariana@gmail.com', '12997881464', 'Rua 15', '12345684', '12345684'),
('Mario', '12345678916', 'mario@gmial.com', '12997881465', 'Rua 16', '12345685', '12345685'),
('Marcos', '12345678917', 'marcos@gmail.com', '12997881466', 'Rua 17', '12345686', '12345686'),
('Marcia', '12345678918', 'marcia@gmail.com', '12997881467', 'Rua 18', '12345687', '12345687'),
('Julia', '12345678919', 'julia@gmail.com', '12997881468', 'Rua 19', '12345688', '12345688'),
('Julio', '12345678920', 'julio@gmail.com', '12997881469', 'Rua 20', '12345689', '12345689'),
('Lucas', '12345678921', 'lucas@gmail.com', '12997881470', 'Rua 21', '12345690', '12345690'),
('Luciana', '12345678922', 'luciana@gmail.com', '12997881471', 'Rua 22', '12345691', '12345691'),
('Luiz', '12345678923', 'luiz@gmail.com', '12997881472', 'Rua 23', '12345692', '12345692'),
('Luiza', '12345678924', 'luiza@gmail.com', '12997881473', 'Rua 24', '12345693', '12345693'),
('Matheus', '12345678925', 'matheus@gmail.com', '12997881474', 'Rua 25', '12345694', '12345694'),
('Marta', '12345678926', 'marta@gmail.com', '12997881475', 'Rua 26', '12345695', '12345695'),
('Bruno', '12345678927', 'bruno@gmail.com', '12997881476', 'Rua 27', '12345696', '12345696'),
('Bruna', '12345678928', 'bruna@gmail.com', '12997881477', 'Rua 28', '12345697', '12345697'),
('Ryan', '12345678929', 'ryan@gmail.com', '12997881478', 'Rua 29', '12345698', '12345698'),
('Felipe', '12345678930', 'felipe@gmail.com', '12997881479', 'Rua 30', '12345699', '12345699'),
('Wellington', '12345678931', 'wellington@gmail.com', '12997881480', 'Rua 31', '12345700', '12345700'),
('Wellen', '12345678932', 'wellen@gmail.com', '12997881481', 'Rua 32', '12345701', '12345701'),
('Ronaldo', '12345678933', 'ronaldo@gmail.com', '12997881482', 'Rua 33', '12345702', '12345702'),
('Juliana', '12345678934', 'juliana@gmail.com', '12997881483', 'Rua 34', '12345703', '12345703'),
('Julieta', '12345678935', 'julieta@gmail.com', '12997881484', 'Rua 35', '12345704', '12345704'),
('Romeu', '12345678936', 'romeu@gmail.com', '12997881485', 'Rua 36', '12345705', '12345705'),
('Ricardo', '12345678937', 'ricardo@gmail.com', '12997881486', 'Rua 37', '12345706', '12345706'),
('Alice', '12345678938', 'alice@gmail.com', '12997881487', 'Rua 38', '12345707', '12345707'),
('Aline', '12345678939', 'aline@gmail.com', '12997881488', 'Rua 39', '12345708', '12345708'),
('Amanda', '12345678940', 'amanda@gmail.com', '12997881489', 'Rua 40', '12345709', '12345709'),
('Caio', '12345678941', 'caio@gmail.com', '12997881490', 'Rua 41', '12345710', '12345710'),
('Caique', '12345678942', 'caique@gmail.com', '12997881491', 'Rua 42', '12345711', '12345711'),
('Cristiano', '12345678943', 'cristiano@gmail.com', '12997881492', 'Rua 43', '12345712', '12345712'),
('Cristina', '12345678944', 'cristina@gmail.com', '12997881493', 'Rua 44', '12345713', '12345713'),
('Cristiane', '12345678945', 'cristiane@gmail.com', '12997881494', 'Rua 45', '12345714', '12345714'),
('Laura', '12345678946', 'laura@gmail.com', '12997881495', 'Rua 46', '12345715', '12345715'),
('Larissa', '12345678947', 'larissa@gmail.com', '12997881496', 'Rua 47', '12345716', '12345716'),
('Leticia', '12345678948', 'leticia@gmail.com', '12997881497', 'Rua 48', '12345717', '12345717'),
('Luis', '12345678949', 'luis@gmail.com', '12997881498', 'Rua 49', '12345718', '12345718'),
('Thaís', '12345678950', 'thais@gmail.com', '12997881499', 'Rua 50', '12345719', '12345719');
 
-- Inserções Chamado
INSERT INTO Chamado (cham_titulo, cham_descricao, cham_status, cham_data_inicio, cham_urgencia, cham_prazo, cham_cli_cpf)
VALUES ('Problema com o computador', 'O computador não está ligando', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678901'),
 ('Problema com o monitor', 'O computador liga mas o monitor não dá vídeo', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678902'),
 ('Problema com o mouse', 'O mouse não está funcionando', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678903'),
 ('Problema com o som', 'O computador não está saindo som', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678904'),
 ('Problema com o bluetooth', 'O bluetooth do computador não tá funcionando', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678905'),
 ('Problema com o teclado', 'O teclado não está funcionando', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678906'),
 ('Problema com o HD', 'O computador não está reconhecendo o HD', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678907'),
 ('Problema com o SSD', 'O computador não está reconhecendo o SSD', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678908'),
 ('Problema com o cooler', 'O cooler do computador não está funcionando', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678909'),
 ('Problema com o processador', 'O processador do computador não está funcionando', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678910'),
 ('Problema com o placa de vídeo', 'A placa de vídeo do computador não está funcionando', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678911'),
 ('Problema com o placa mãe', 'A placa mãe do computador não está funcionando', 'Aberto', '2020-10-01', 'media', '2020-10-02', '12345678912'),
 ('Problema com vírus', 'Meu computador está com um malwere', 'Aberto', '2020-10-01', 'alta', '2020-10-02', '12345678913'),
 ('Problema com o SO', 'Meu computador está com um problema no sistema operacional', 'Aberto', '2020-10-01', 'alta', '2020-10-02', '12345678914'),
 ('Problema com o windows', 'Meu computador está com um problema no windows11, versão PRO', 'Aberto', '2020-10-01', 'alta', '2020-10-02', '12345678915'),
 ('Problema com o linux', 'Meu computador está com um problema no linux', 'Aberto', '2020-10-01', 'alta', '2020-10-02', '12345678916'),
 ('Problema com o mac', 'Meu computador está com um problema no mac', 'Em Andamento', '2020-09-29', 'alta', '2020-09-30', '12345678917'),
 ('Problema com o android', 'Meu celular está com um problema no android', 'Em Andamento', '2020-09-29', 'alta', '2020-09-30', '12345678918'),
 ('Problema com o ios', 'Meu celular está com um problema no ios', 'Em Andamento', '2020-09-29', 'alta', '2020-09-30', '12345678919'),
 ('Problema com o iphone', 'Meu iphone12 não está carregando', 'Em Andamento', '2020-09-29', 'alta', '2020-09-30', '12345678920'),
 ('Problema com o ipad', 'Meu ipad molhou e agora não quer ligar', 'Em Andamento', '2020-09-29', 'alta', '2020-09-30', '12345678921'),
 ('Problema com a bateria', 'A bateria do meu celular não está carregando', 'Em Andamento', '2020-09-29', 'alta', '2020-09-30', '12345678922'),
 ('Problema com o carregador', 'O carregador do meu celular não está funcionando', 'Em Andamento', '2020-09-29', 'alta', '2020-09-30', '12345678923'),
 ('Problema com o fone de ouvido', 'O fone de ouvido do meu celular não está funcionando', 'Em Andamento', '2020-09-29', 'alta', '2020-09-30', '12345678924'),
 ('Problema com o microfone', 'O microfone do meu celular não está funcionando', 'Em Andamento', '2020-09-29', 'alta', '2020-09-30', '12345678925'),
 ('Problema com o alto falante', 'O alto falante do meu celular não está funcionando', 'Em Andamento', '2020-09-29', 'alta', '2020-09-30', '12345678926'),
 ('Problema com o wi-fi', 'O wi-fi do meu celular não está funcionando', 'Em Andamento', '2020-09-29', 'alta', '2020-09-30', '12345678927'),
 ('Problema com o bluetooth', 'O bluetooth do meu celular não está funcionando', 'Em Andamento', '2020-10-01', 'urgente', '2020-10-01', '12345678928'),
 ('Problema com o 4G', 'O 4G do meu celular não está funcionando', 'Em Andamento', '2020-10-01', 'urgente', '2020-10-01', '12345678929'),
 ('Problema com o chip', 'O meu celular não está reconhecendo o chip da operadora', 'Em Andamento', '2020-10-01', 'urgente', '2020-10-01', '12345678930'),
 ('Problema no cartão de memória', 'O meu celular não está reconhecendo o cartão de memória', 'Em Andamento', '2020-10-01', 'urgente', '2020-10-01', '12345678931'),
 ('Problema com o micro sd', 'O meu celular não está reconhecendo o micro sd', 'Em Andamento', '2020-10-01', 'urgente', '2020-10-01', '12345678932'),
 ('Problema com o GPS', ' não está funcionando o GPS do meu celular', 'Concluido', '2020-09-27', 'urgente', '2020-09-27', '12345678933'),
 ('Problema com o touch', 'O touch do meu celular não está funcionando', 'Concluido', '2020-09-27', 'urgente', '2020-09-27', '12345678934'),
 ('Problema com o display', 'O display do meu celular não está funcionando', 'Concluido', '2020-09-27', 'urgente', '2020-09-27', '12345678935'),
 ('Problema com a impressora', 'A minha impressora está com tanque de tinta cheio mas não está reconhecendo.', 'Concluido', '2020-09-27', 'urgente', '2020-09-27', '12345678936'),
 ('Problema com o scanner', 'O scanner da minha impressora não está funcionando', 'Concluido', '2020-09-27', 'urgente', '2020-09-27', '12345678937'),
 ('Problema de bateria SmartWatch', 'Meu Smartwatch está com problema e não carrega', 'Concluido', '2020-09-27', 'urgente', '2020-09-27', '12345678938'),
 ('Problema com o teclado', 'O teclado do meu notebook não está funcionando', 'Concluido', '2020-09-27', 'urgente', '2020-09-27', '12345678939'),
 ('Problema de Segurança', 'Vírus detectado', 'Concluido', '2020-09-27', 'urgente', '2020-09-27', '12345678940'),
 ('Backup Não Realizado', 'Backup automático não está funcionando','Concluido', '2020-09-27', 'urgente', '2020-09-27', '12345678941'),
 ('Problema de Hardware', 'Hardware defeituoso', 'Aberto', '2020-09-27', 'alta', '2020-09-27', '12345678942'),
 ('Problema com Antivírus', 'Antivírus desativado', 'Em Andamento' ,'2020-09-27', 'media', '2020-09-28' ,'12345678943'),
 ('Erro no Excel', 'Excel trava ao abrir', 'Em Andamento' ,'2020-09-27', 'media', '2020-09-28' ,'12345678944'),
 ('Problema de Acesso', 'Não consigo acessar a rede', 'Aberto', '2020-12-16', 'baixa', '2020-12-20', '12345678945'),
 ('Problema de Energia', 'Computador desliga inesperadamente', 'Em Andamento', '2020-12-17', 'media','2020-12-22','12345678946'),
 ('Problema com Monitor', 'Monitor piscando', 'Concluido', '2020-12-18', 'baixa','2020-12-22','12345678947'),
 ('Problema de Áudio', 'Sem som no computador', 'Aberto', '2020-12-19','baixa','2020-12-21','12345678948'),
 ('Problema de Acesso', 'Usuário com dificuldade de acessar o sistema', 'Aberto', '2020-12-02', 'media', '2020-12-03','12345678949'),
 ('Problema de Impressão', 'Impressora não está imprimindo corretamente', 'Em Andamento', '2020-12-03', 'alta', '2023-12-05', '12345678950');
 
-- Inserções Suporte
INSERT INTO Suporte (sup_cpf, sup_nome, sup_email, sup_telefone, sup_senha)
VALUES ('12345678951', 'Gilson dos Anjos Ribeiro', 'suporte1@gmail.com', '12997881456', 'suporte1'),
    ('12345678952', 'Luciana Guerra Pereira Cotti Costa', 'suporte2@gmail.com', '12997881457', 'suporte2'),
    ('12345678953', 'Susana Maria Berger', 'suporte3@gmail.com', '12997881458', 'suporte3'),
    ('12345678954', 'Valdirene Faria', 'suporte4@gmail.com','12997881459', 'suporte4'),
    ('12345678955', 'Daisylucy Quintanilha Ribeiro', 'suporte5@gmail.com','12997881460', 'suporte5'),
    ('12345678956', 'Regiane Moraes Silva', 'suporte6@gmail.com','12997881461', 'suporte6'),
    ('12345678957', 'Maury Cezar da Silva', 'suporte7@gmail.com','12997881462', 'suporte7'),
    ('12345678958', 'Susana Maria Berger', 'suporte8@gmail.com','12997881463', 'suporte8'),
    ('12345678959', 'Hanna Hapque de Lima Bezerra', 'suporte9@gmail.com','12997881464', 'suporte9'),
    ('12345678960', 'Evelyn', 'suporte10@gmail.com','12997881465', 'suport10'),
    ('12345678961', 'Gustavo', 'suporte11@gmail.com','12997881466', 'suport11'),
    ('12345678962', 'Raquel', 'suporte12@gmail.com','12997881467', 'suport12'),
    ('12345678963', 'Thainara', 'suporte13@gmail.com', '12997881468', 'suport13');
 
-- Inserções FAQ
INSERT INTO FAQ (faq_pergunta, faq_resposta, faq_sup_id)
VALUES('Como posso redefinir minha senha?', 'Você pode redefinir sua senha acessando a página de recuperação de senha em nosso site e seguindo as instruções fornecidas.',1),
('Qual é o horário de atendimento?', 'Nosso horário de atendimento é das 9h às 18h, de segunda a sexta-feira. Estamos fechados nos fins de semana e feriados.',2),
('Como posso abrir um novo chamado de suporte?', 'Para abrir um novo chamado de suporte, faça login em sua conta e vá para a seção de suporte. Clique em "Abrir Chamado" e preencha o formulário com os detalhes do problema.',4),
('Existe um número de telefone de suporte?', 'Sim, nosso número de suporte é (XX) XXXX-XXXX. Estamos disponíveis durante o horário comercial para ajudar com suas dúvidas e problemas.',8),
('Como verificar o status do meu chamado?', 'Você pode verificar o status do seu chamado fazendo login em sua conta e indo para a seção de suporte. Lá, você encontrará uma lista de seus chamados com os status correspondentes.',12),
('Posso cancelar um chamado após aberto?', 'Sim, basta você deletar o chamado. Recomendamos também que ao abrir um chamado, você forneça o máximo de detalhes possível ao abrir um chamado para uma resolução mais rápida.',3),
('Qual é o tempo médio de resposta?', 'O tempo de resposta pode variar de acordo com a urgência de seu chamado, para chamados urgentes o prazo de respota é de até 1 hora, para urgencia alta o prazo é de 12 horas, para media é de 1 dia, para baixa é de 2 dias. No entanto, esse tempo pode variar de acordo com a demanda ou complexidade do problema.',5),
('Posso adicionar mais informações ao meu chamado?', 'Sim, você pode adicionar mais informações ao seu chamado respondendo ao e-mail de confirmação que recebeu. Isso ajudará nossa equipe a entender melhor a situação e fornecer uma solução mais rápida.',7),
('Como posso atualizar minhas informações de contato?', 'Para atualizar suas informações de contato, faça login em sua conta e vá para as configurações de perfil. Lá, você encontrará opções para editar suas informações, incluindo email e número de telefone.',10),
('O que fazer se minha pergunta não estiver aqui?', 'Se sua pergunta não estiver na lista, entre em contato conosco através do formulário de suporte ou do número fornecido, e ficaremos felizes em ajudar.',3),
('Como faço para instalar a última atualização do software?', 'Para instalar a última atualização do software, visite nossa página de downloads e siga as instruções fornecidas para a versão mais recente do produto.',6),
('Posso transferir minha licença para outro dispositivo?', 'Sim, você pode transferir sua licença para outro dispositivo. Entre em contato conosco e forneceremos as instruções necessárias para realizar a transferência.',11),
('Qual é a política de reembolso?', 'Nossa política de reembolso permite reembolsos dentro dos primeiros 30 dias após a compra. Certifique-se de ler nossos termos e condições para obter informações detalhadas.', 9),
('Como faço para relatar um bug no software?', 'Para relatar um bug no software, vá para a seção de suporte em nosso site e selecione a opção "Relatar Bug". Descreva o problema detalhadamente para que nossa equipe possa investigar.',5),
('Onde posso encontrar tutoriais sobre o uso do software?', 'Oferecemos tutoriais em vídeo e documentação detalhada em nossa página de suporte. Explore esses recursos para obter ajuda na instalação e no uso do software.', 2);
 
 
-- Inserções RespostaChamado
INSERT INTO RespostaChamado (resp_soluc_comum, resp_data, resp_sup_id, resp_cham_id)
VALUES ('O mac estava com problema, reinstale o mac', '2020-10-01', 2, 17),
 ('O android estava com problema, reinstale o android', '2020-10-01', 3, 18),
 ('O ios estava com problema, reinstale o ios', '2020-10-01', 4, 19),
 ('O iphone estava com problema, reinstale o iphone', '2020-10-01', 5, 20),
 ('O ipad estava com problema, reinstale o ipad', '2020-10-01', 6, 21),
 ('A bateria estava com problema, troque a bateria', '2020-10-01', 7, 22),
 ('O carregador estava com problema, troque o carregador', '2020-10-01', 8, 23),
 ('O fone de ouvido estava com problema, troque o fone de ouvido', '2020-10-01', 9, 24),
 ('O microfone estava com problema, troque o microfone', '2020-10-01', 10, 25),
 ('O alto falante estava com problema, troque o alto falante', '2020-10-01', 11, 26),
 ('O wi-fi estava com problema, reinstale o wi-fi', '2020-10-01', 12, 27),
 ('O bluetooth estava com problema, reinstale o bluetooth', '2020-10-01', 13, 28),
 ('O 4G estava com problema, reinstale o 4G', '2020-10-01', 1, 29),
 ('O chip estava com problema, reinstale o chip', '2020-10-01', 2, 30),
 ('O cartão de memória estava com problema, reinstale o cartão de memória', '2020-10-01', 3, 31),
 ('O micro sd estava com problema, reinstale o micro sd', '2020-10-01', 4, 32),
 ('O GPS estava com problema, reinstale o GPS', '2020-10-01', 5, 33),
 ('O touch estava com problema, reinstale o touch', '2020-10-01', 6, 34),
 ('O display estava com problema, reinstale o display', '2020-10-01', 8, 35),
 ('O tanque de tinta estava cheio, esvazie o tanque de tinta', '2020-10-01', 9, 36),
 ('O scanner estava com problema, reinstale o scanner', '2020-10-01', 10, 37),
 ('A bateria estava com problema, troque a bateria', '2020-10-01', 11, 38),
 ('O teclado estava com problema, troque o teclado', '2020-10-01', 12, 39),
 ('O antivírus estava desativado, ative o antivírus', '2020-10-01', 13, 40),
 ('O backup automático estava desativado, ative o backup automático', '2020-10-01', 5, 41),
 ('O antivírus estava desativado, ative o antivírus', '2020-10-01', 7, 43),
 ('O excel estava com problema, reinstale o excel', '2020-10-01', 8, 44),
 ('O computador estava com problema de energia, troque a fonte de energia', '2020-10-01', 11, 46),
 ('O monitor estava com problema, troque o monitor', '2020-10-01', 12, 47),
 ('A impressora estava com problema, troque a impressora', '2020-10-01', 3, 50);
 
-- Inserções Equipamento
INSERT INTO Equipamento (equ_nome, equ_numserie, equ_tipo, equ_cham_id, equ_sup_id)
VALUES ('PC para Chamado 1', '1254ZX5FG001', 'pc desktop', 1, 2),
 ('Caixa de Som Chamado 4', '1254ZX5FG002', 'jbl caixa de som', 4, 8),
 ('HD Chamado 7', '1254ZX5FG003', 'HD', 7, 10),
 ('PC Chamado 14', '1254ZX5FG004', 'pc desktop', 14, 6),
 ('PC Chamado 16', '1254ZX5FG005', 'pc desktop', 16, 9),
 ('Celular Iphone Chamado 19', '1254ZX5FG006', 'iphone12', 19, 12),
 ('Tablet Ipad Chamado 21', '1254ZX5FG007', 'ipad pro', 21, 3),
 ('Fone de Ouvido Chamado 24', '1254ZX5FG008', 'air dot12', 24, 1),
 ('Celular LG Chamado 31', '1254ZX5FG009', 'LG K14', 31, 11),
 ('Celular Motorola Chamado 33', '1254ZX5FG010', 'MOTO G3', 33, 7),
 ('Smartwach Chamado 38', '1254ZX5FG011', 'relógio digital', 38, 5),
 ('Notebook Chamado 41', '1254ZX5FG012', 'nootebook idea pad 12', 41, 4),
 ('Notebook Chamado 44', '1254ZX5FG013', 'nootebook aspire 11', 44, 2),
 ('Monitor Chamado 47', '1254ZX5FG014', 'monitor 4K LG Oblivion', 47, 8),
 ('Impressora Chamado 50', '1254ZX5FG015', 'EPSON E53', 50, 1);