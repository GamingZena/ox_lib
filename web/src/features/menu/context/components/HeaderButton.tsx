import { Button, createStyles } from '@mantine/core';
import { IconProp } from '@fortawesome/fontawesome-svg-core';
import LibIcon from '../../../../components/LibIcon';

interface Props {
  icon: IconProp;
  canClose?: boolean;
  iconSize: number;
  handleClick: () => void;
}

const useStyles = createStyles((theme, params: { canClose?: boolean }) => ({
  button: {
<<<<<<< HEAD
=======
    borderRadius: 4,
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    flex: '1 15%',
    alignSelf: 'stretch',
    height: 'auto',
    textAlign: 'center',
    justifyContent: 'center',
    padding: 2,
<<<<<<< HEAD
    backgroundColor: 'transparent',
    color: 'white',
    textShadow: '0px 0px 100px white',
    borderRadius: 0,
    transition: 'all .2s ease',
    '&:hover': {
      backgroundColor: '#f72f49',
    },
=======
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  },
  root: {
    border: 'none',
  },
  label: {
<<<<<<< HEAD
    color: params.canClose === false ? theme.colors.dark[2] : 'white',
=======
    color: params.canClose === false ? theme.colors.dark[2] : theme.colors.dark[0],
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  },
}));

const HeaderButton: React.FC<Props> = ({ icon, canClose, iconSize, handleClick }) => {
  const { classes } = useStyles({ canClose });

  return (
    <Button
      variant="default"
      className={classes.button}
      classNames={{ label: classes.label, root: classes.root }}
      disabled={canClose === false}
      onClick={handleClick}
    >
      <LibIcon icon={icon} fontSize={iconSize} fixedWidth />
    </Button>
  );
};

export default HeaderButton;
