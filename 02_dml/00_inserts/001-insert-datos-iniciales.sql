INSERT INTO users (nombre, email, password, rol)
VALUES
('Yeison', 'yeison@gmail.com', '123456789', 'CLIENTE'),
('Paula', 'paula@gmail.com', '123456789', 'CLIENTE');

INSERT INTO turnos (doctor, especialidad, estado, fecha_creacion, fecha_hora, id_usuario)
VALUES
('Dr. Andrés Muñoz', 'Medicina General', 'PENDIENTE', NOW(), '2026-04-16 08:00:00', 1),
('Dra. Laura Soto', 'Cardiología', 'PENDIENTE', NOW(), '2026-04-22 16:00:00', 2);