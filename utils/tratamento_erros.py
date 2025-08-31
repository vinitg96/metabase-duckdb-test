from loguru import logger
from functools import wraps
import time

def tratar_erros(func):
    @wraps(func) #preserva metadados da função embrulhada
    def wrapper(*args, **kwargs):
        if func.__name__ == 'read_and_execute_query':
            logger.info(f"Iniciando {func.__name__} - {args[0]}")
        try:
            start_time = time.time()
            result = func(*args, **kwargs)
            logger.info(f"{func.__name__} - {args[0]} executado em {time.time() - start_time:.2f} segundos")
            logger.debug(f"Executando: {func.__qualname__} - args: {args} kwargs: {kwargs}")
            return result
        except Exception as e:
            logger.error(f"Erro na função: {e.__class__}|{func.__qualname__} - args: {args} kwargs: {kwargs} - {repr(e)}")
            return None # não quebra pipeline #raise quebra. logger.exception levanta exceção
    return wrapper


def log_stage(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        logger.info(f"Entering: {func.__name__}")
        start = time.time()
        try:
            result = func(*args, **kwargs)  # result might be None
            logger.info(f"Completed: {func.__name__} in {time.time() - start:.2f}s")
            return result # None is still returned here if the function didn't return anything
        except Exception as e:
            logger.error(f"Failed: {func.__name__} with error: {repr(e)}")
            #raise
            return None
    return wrapper

#raise # realça a mesma exceção após ser logada. Evita erro solincioso e garante tratamento em outro nivel

def base_tratar_erros(func):
    @wraps(func) #preserva metadados da função embrulhada
    def wrapper(*args, **kwargs):

        logger.info(f"Iniciando {func.__name__} - {args[0]}")
        try:
            logger.debug(f"Executando: {func.__qualname__} - args: {args} kwargs: {kwargs}")
            return func(*args, **kwargs)
        except Exception as e:
            logger.error(f"Erro na função: {e.__class__}|{func.__qualname__} - args: {args} kwargs: {kwargs} - {repr(e)}")
            return None # não quebra pipeline #raise quebra. logger.exception levanta exceção
    return wrapper