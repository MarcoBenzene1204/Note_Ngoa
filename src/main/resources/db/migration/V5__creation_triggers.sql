-- Creation des triggers --

CREATE TRIGGER update_plans_abonnement_updated_at BEFORE UPDATE ON plans_abonnement FOR EACH ROW EXECUTE PROCEDURE update_updated_at();
CREATE TRIGGER update_souscriptions_updated_at BEFORE UPDATE ON souscription FOR EACH ROW EXECUTE PROCEDURE update_updated_at();
CREATE TRIGGER update_transactions_updated_at BEFORE UPDATE ON transactions FOR EACH ROW EXECUTE PROCEDURE update_updated_at();
