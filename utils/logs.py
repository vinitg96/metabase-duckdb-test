from loguru import logger
import sys
import os

def configurar_logger(pasta_logs:str = "logs") -> None:
    """
    Configura múltiplos sinks para o logger global do Loguru.

    - Console (stdout) com nível INFO+
    - Arquivo de erros (ERROR+) com rotação e retenção
    - Arquivo de debug (DEBUG+) com rotação e compressão
    """
    
    os.makedirs(pasta_logs, exist_ok=True)


    # Remove qualquer configuração existente (evita logs duplicados)
    logger.remove()

    # Sink 1: Terminal (INFO+)
    logger.add(
        sys.stdout,
        level="INFO",
        format="<green>{time:HH:mm:ss}</green> | <level>{level: <8}</level> | <cyan>{message}</cyan>",
        backtrace=True,
        diagnose=True,
        catch=False
    )

    # Sink 2: Arquivo de erros (ERROR+)
    logger.add(
        f"{pasta_logs}/erros.log",
        level="ERROR",
        format="{time:YYYY-MM-DD HH:mm:ss} | {level} | {message}",
        rotation="1 MB",
        retention="7 days",
        enqueue=True,
        backtrace=True,
        diagnose=True
    )

    # Sink 3: Arquivo debug completo (DEBUG+)
    logger.add(
        f"{pasta_logs}/debug.log",
        level="DEBUG",
        format="{time} | {level} | {name}:{function}:{line} - {message}",
        rotation="10 MB",
        compression="zip",
        enqueue=True
    )