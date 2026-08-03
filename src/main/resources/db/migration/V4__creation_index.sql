-- creation des index --

CREATE INDEX idx_souscriptions_user_statut ON souscription(id_user , statut);
CREATE INDEX idx_souscriptions_dates ON souscription(date_debut, date_fin);
CREATE INDEX idx_achats_user_ressource ON achats_ressources(user_id, ressource_id);
CREATE INDEX idx_transactions_user_statut ON transactions(user_id, statut);
CREATE INDEX idx_ressources_payantes ON ressources(est_payante, prix);
